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

    // --- 1. Base Glass Normal & Refraction ---
    float eps = 1.5;
    vec2 barNormal = normalize(vec2(
        sdRoundedBox(p + vec2(eps, 0.0), barCenter, radius) - sdRoundedBox(p - vec2(eps, 0.0), barCenter, radius),
        sdRoundedBox(p + vec2(0.0, eps), barCenter, radius) - sdRoundedBox(p - vec2(0.0, eps), barCenter, radius)
    ));

    float barBevelRatio = clamp(-dBar / max(uBevelDepth, 1.0), 0.0, 1.0);
    float baseLens = sin((1.0 - barBevelRatio) * 1.5707963);
    vec2 baseOffset = barNormal * baseLens * uRefraction;

    // --- 2. Active Tab Capsule SDF ---
    vec2 pPill = localPos - uSelectedCenter;
    float dPill = sdRoundedBox(pPill, uSelectedHalfSize, uSelectedRadius);

    vec2 pillNormal = normalize(vec2(
        sdRoundedBox(pPill + vec2(eps, 0.0), uSelectedHalfSize, uSelectedRadius) - sdRoundedBox(pPill - vec2(eps, 0.0), uSelectedHalfSize, uSelectedRadius),
        sdRoundedBox(pPill + vec2(0.0, eps), uSelectedHalfSize, uSelectedRadius) - sdRoundedBox(pPill - vec2(0.0, eps), uSelectedHalfSize, uSelectedRadius)
    ));

    float pillEdge = smoothstep(12.0, 0.0, abs(dPill));
    vec2 pillOffset = pillNormal * pillEdge * (uRefraction * 0.35);

    vec2 baseUV = safeUV(bgUV + baseOffset + pillOffset);
    float disp = uDispersion * (baseLens + pillEdge * 0.4);

    // --- 3. Multi-tap Frosted Background ---
    float spread = (1.0 - barBevelRatio * 0.5) * 0.0025;
    vec4 centerCol = texture(uTexture, baseUV);
    vec4 leftCol   = texture(uTexture, safeUV(baseUV - vec2(spread, 0.0)));
    vec4 rightCol  = texture(uTexture, safeUV(baseUV + vec2(spread, 0.0)));
    vec4 topCol    = texture(uTexture, safeUV(baseUV - vec2(0.0, spread)));
    vec4 bottomCol = texture(uTexture, safeUV(baseUV + vec2(0.0, spread)));

    vec3 blurredScene = (centerCol.rgb * 0.4) + ((leftCol.rgb + rightCol.rgb + topCol.rgb + bottomCol.rgb) * 0.15);
    blurredScene.r = texture(uTexture, safeUV(baseUV + barNormal * disp)).r;
    blurredScene.b = texture(uTexture, safeUV(baseUV - barNormal * disp)).b;

    // --- 4. Ambient & Specular Lighting ---
    float barTopLight = pow(1.0 - barBevelRatio, 2.5) * max(0.0, -barNormal.y) * 0.5;
    float barBottomRim = pow(1.0 - barBevelRatio, 3.5) * max(0.0, barNormal.y) * 0.18;

    float pillRim = smoothstep(2.5, 0.0, abs(dPill)) * 0.35;
    float pillTopHighlight = max(0.0, -pillNormal.y) * smoothstep(8.0, 0.0, abs(dPill)) * 0.28;
    
    float insidePillFactor = clamp(-dPill / max(uSelectedRadius, 1.0), 0.0, 1.0);
    float pillVolumetricGlow = pow(insidePillFactor, 1.2) * 0.14;

    vec3 highlights = vec3(barTopLight + barBottomRim + pillRim + pillTopHighlight + pillVolumetricGlow);
    vec3 composite = blurredScene + highlights;

    // --- 5. Translucency & Tints ---
    vec3 tintedGlass = mix(composite, uTintColor.rgb, uTintColor.a);

    float isInside = 1.0 - smoothstep(-0.5, 0.5, dPill);
    vec3 finalRgb = mix(tintedGlass, uSelectedColor.rgb, uSelectedColor.a * isInside);

    float alpha = 1.0 - smoothstep(-0.8, 0.0, dBar);
    fragColor = vec4(finalRgb * alpha, alpha);
}
