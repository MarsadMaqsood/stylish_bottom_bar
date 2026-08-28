import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';

class LiquidGlassShader {
  static ui.FragmentProgram? _program;

  /// Pre-loads and caches the shader program
  static Future<ui.FragmentProgram?> load() async {
    if (_program != null) return _program;
    try {
      _program = await ui.FragmentProgram.fromAsset(
        'packages/stylish_bottom_bar/shaders/liquid_glass.frag',
      );
      return _program;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to load stylish_bottom_bar liquid_glass.frag: $e');
      }
      return null;
    }
  }

  /// Synchronous getter if already loaded
  static ui.FragmentShader? createShader() => _program?.fragmentShader();
}
