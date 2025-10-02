import 'dart:ui';

import 'package:flutter/material.dart';

import '../env/app_env.dart';

class AppColorTokens extends ThemeExtension<AppColorTokens> {
  const AppColorTokens({
    required this.primary,
    required this.onPrimary,
    required this.success,
    required this.warning,
    required this.error,
    required this.background,
    required this.onBackground,
  });

  final Color primary;
  final Color onPrimary;
  final Color success;
  final Color warning;
  final Color error;
  final Color background;
  final Color onBackground;

  factory AppColorTokens.fromColorScheme(ColorScheme scheme) {
    return AppColorTokens(
      primary: scheme.primary,
      onPrimary: scheme.onPrimary,
      success: scheme.secondary,
      warning: scheme.tertiary,
      error: scheme.error,
      background: scheme.surface,
      onBackground: scheme.onSurface,
    );
  }

  @override
  ThemeExtension<AppColorTokens> copyWith({
    Color? primary,
    Color? onPrimary,
    Color? success,
    Color? warning,
    Color? error,
    Color? background,
    Color? onBackground,
  }) {
    return AppColorTokens(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      error: error ?? this.error,
      background: background ?? this.background,
      onBackground: onBackground ?? this.onBackground,
    );
  }

  @override
  ThemeExtension<AppColorTokens> lerp(ThemeExtension<AppColorTokens>? other, double t) {
    if (other is! AppColorTokens) {
      return this;
    }
    return AppColorTokens(
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t) ?? onPrimary,
      success: Color.lerp(success, other.success, t) ?? success,
      warning: Color.lerp(warning, other.warning, t) ?? warning,
      error: Color.lerp(error, other.error, t) ?? error,
      background: Color.lerp(background, other.background, t) ?? background,
      onBackground: Color.lerp(onBackground, other.onBackground, t) ?? onBackground,
    );
  }
}

class AppSpacingTokens extends ThemeExtension<AppSpacingTokens> {
  const AppSpacingTokens({
    this.xs = 4,
    this.sm = 8,
    this.md = 12,
    this.lg = 16,
    this.xl = 24,
  });

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;

  @override
  ThemeExtension<AppSpacingTokens> copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
  }) {
    return AppSpacingTokens(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
    );
  }

  @override
  ThemeExtension<AppSpacingTokens> lerp(ThemeExtension<AppSpacingTokens>? other, double t) {
    if (other is! AppSpacingTokens) {
      return this;
    }
    return AppSpacingTokens(
      xs: lerpDouble(xs, other.xs, t) ?? xs,
      sm: lerpDouble(sm, other.sm, t) ?? sm,
      md: lerpDouble(md, other.md, t) ?? md,
      lg: lerpDouble(lg, other.lg, t) ?? lg,
      xl: lerpDouble(xl, other.xl, t) ?? xl,
    );
  }
}

class AppRadiusTokens extends ThemeExtension<AppRadiusTokens> {
  const AppRadiusTokens({
    this.sm = 8,
    this.md = 12,
    this.lg = 16,
  });

  final double sm;
  final double md;
  final double lg;

  @override
  ThemeExtension<AppRadiusTokens> copyWith({
    double? sm,
    double? md,
    double? lg,
  }) {
    return AppRadiusTokens(
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
    );
  }

  @override
  ThemeExtension<AppRadiusTokens> lerp(ThemeExtension<AppRadiusTokens>? other, double t) {
    if (other is! AppRadiusTokens) {
      return this;
    }
    return AppRadiusTokens(
      sm: lerpDouble(sm, other.sm, t) ?? sm,
      md: lerpDouble(md, other.md, t) ?? md,
      lg: lerpDouble(lg, other.lg, t) ?? lg,
    );
  }
}

class AppTheme {
  const AppTheme._();

  static ThemeData light(AppEnv env) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seedColor(env.flavor),
      brightness: Brightness.light,
    );
    final textTheme = Typography.material2021().black.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: colorScheme.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(const AppRadiusTokens().md),
        ),
      ),
      extensions: <ThemeExtension<dynamic>>[
        AppColorTokens.fromColorScheme(colorScheme),
        const AppSpacingTokens(),
        const AppRadiusTokens(),
      ],
    );
  }

  static Color _seedColor(AppFlavor flavor) {
    switch (flavor) {
      case AppFlavor.dev:
        return const Color(0xFF4F46E5);
      case AppFlavor.stg:
        return const Color(0xFF0EA5E9);
      case AppFlavor.prod:
        return const Color(0xFF0F766E);
    }
  }
}

extension AppThemeData on ThemeData {
  AppColorTokens get colors => extension<AppColorTokens>()!;
  AppSpacingTokens get spacing => extension<AppSpacingTokens>()!;
  AppRadiusTokens get radii => extension<AppRadiusTokens>()!;
}
