#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 uScreenSize;
uniform vec2 uBarOrigin;
uniform vec2 uBarSize;
uniform float uCornerRadius;
uniform float uRefraction;
uniform float uDispersion;
uniform float uBevelDepth;
uniform vec4 uTintColor;
uniform vec2 uSelectedCenter;
uniform vec2 uSelectedHalfSize;
uniform float uSelectedRadius;
uniform vec4 uSelectedColor;
uniform sampler2D uTexture;

out vec4 fragColor;

float sdRoundedBox(vec2 p, vec2 b, float r) {
    vec2 q = abs(p) - b + vec2(r);
    return min(max(q.x, q.y), 0.0) + length(max(q, 0.0)) - r;
}

vec2 safeUV(vec2 uv) {
    return clamp(uv, vec2(0.001), vec2(0.999));
}

void main() {
    vec2 screenCoord = FlutterFragCoord().xy;
    vec2 bgUV = screenCoord / uScreenSize;

    vec2 localPos = screenCoord - uBarOrigin;
    vec2 barCenter = uBarSize * 0.5;
    vec2 p = localPos - barCenter;
    float radius = clamp(uCornerRadius, 0.0, min(barCenter.x, barCenter.y));

    // Outer Bar SDF
    float dBar = sdRoundedBox(p, barCenter, radius);
    if (dBar > 0.0) {
        fragColor = vec4(0.0);
        return;
    }

    // Normal calculation
    float eps = 1.5;
    vec2 barNormal = normalize(vec2(
        sdRoundedBox(p + vec2(eps, 0.0), barCenter, radius) - sdRoundedBox(p - vec2(eps, 0.0), barCenter, radius),
        sdRoundedBox(p + vec2(0.0, eps), barCenter, radius) - sdRoundedBox(p - vec2(0.0, eps), barCenter, radius)
    ));

    // Refraction offset
    float barBevelRatio = clamp(-dBar / max(uBevelDepth, 1.0), 0.0, 1.0);
    vec2 baseOffset = barNormal * (1.0 - barBevelRatio) * uRefraction * 1.5;

    // Active Tab Pill SDF
    vec2 pPill = localPos - uSelectedCenter;
    float dPill = sdRoundedBox(pPill, uSelectedHalfSize, uSelectedRadius);

    vec2 pillNormal = normalize(vec2(
        sdRoundedBox(pPill + vec2(eps, 0.0), uSelectedHalfSize, uSelectedRadius) - sdRoundedBox(pPill - vec2(eps, 0.0), uSelectedHalfSize, uSelectedRadius),
        sdRoundedBox(pPill + vec2(0.0, eps), uSelectedHalfSize, uSelectedRadius) - sdRoundedBox(pPill - vec2(0.0, eps), uSelectedHalfSize, uSelectedRadius)
    ));

    float pillEdge = smoothstep(10.0, 0.0, abs(dPill));
    vec2 pillOffset = pillNormal * pillEdge * (uRefraction * 0.5);

    vec2 finalUV = safeUV(bgUV + baseOffset + pillOffset);
    float disp = uDispersion * 2.5;

    // Chromatic aberration sample
    vec3 scene;
    scene.r = texture(uTexture, safeUV(finalUV + vec2(disp, 0.0))).r;
    scene.g = texture(uTexture, safeUV(finalUV)).g;
    scene.b = texture(uTexture, safeUV(finalUV - vec2(disp, 0.0))).b;

    // --- Custom Neon Cyber Aesthetic Highlights ---
    vec3 neonCyan = vec3(0.0, 0.9, 1.0);
    vec3 neonMagenta = vec3(1.0, 0.08, 0.58);

    // Neon edge glow along the bar border
    float borderGlow = smoothstep(6.0, 0.0, abs(dBar));
    vec3 edgeGlow = mix(neonCyan, neonMagenta, clamp((localPos.x / uBarSize.x), 0.0, 1.0)) * borderGlow * 0.75;

    // Active Pill Neon Halo & Volumetric Core
    float pillGlow = smoothstep(14.0, 0.0, abs(dPill)) * 0.6;
    float insidePill = 1.0 - smoothstep(-1.0, 1.0, dPill);
    vec3 pillHighlight = mix(neonMagenta, neonCyan, clamp(0.5 + pPill.x / (uSelectedHalfSize.x * 2.0), 0.0, 1.0)) * (pillGlow + insidePill * 0.25);

    // Composite Glass
    vec3 darkTint = vec3(0.05, 0.05, 0.12);
    vec3 glassColor = mix(scene * 0.85 + darkTint * 0.15, edgeGlow + pillHighlight, 0.65);

    float alpha = 1.0 - smoothstep(-1.0, 0.0, dBar);
    fragColor = vec4(glassColor * alpha, alpha * 0.95);
}
