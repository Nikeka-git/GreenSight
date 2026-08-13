import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ДИЗАЙН-СИСТЕМА GREENSIGHT
/// ==========================
/// Идея: не "очередное эко-приложение с ярко-зелёным Material Design",
/// а визуальный язык полевого определителя растений / бирки лесника —
/// как на настоящих пронумерованных бирках деревьев в парках Костаная.
/// Тёплая бумага, чернильно-зелёный, ржаво-охристый акцент вместо
/// дежурного "материального" зелёного (#4CAF50).
///
/// Палитра называется по материалам самого предмета: кора, берёста, мох,
/// ржавчина металлической бирки, степное небо.
class AppColors {
  AppColors._();

  // --- Основные ---
  static const canopy = Color(0xFF1F3D2B); // тёмная хвоя/крона — primary
  static const canopyLight = Color(0xFF3C6B4E); // подсветка/hover кроны
  static const bark = Color(0xFF4A3428); // кора — тёмный нейтральный
  static const birch = Color(0xFFF6F1E4); // берёста — фон приложения
  static const birchCard = Color(0xFFFFFDF7); // светлее фона — карточки

  // --- Акценты ---
  static const lichen = Color(0xFF8FA678); // мох — вторичный зелёный
  static const amber = Color(0xFFC97D3C); // ржавчина бирки — CTA/приоритет
  static const rust = Color(0xFFA8462F); // критично/ошибка
  static const steppeBlue = Color(0xFF5D7F97); // степное небо — инфо/AI

  // --- Текст ---
  static const ink = Color(0xFF23291F);
  static const inkMuted = Color(0xFF6F6656);
  static const inkFaint = Color(0xFFA79E8C);

  // --- Служебные ---
  static const divider = Color(0xFFE4DBC7);
  static const shadow = Color(0x1A1F3D2B);
}

/// Цвета статусов заявки — используются и в тексте, и в SpecimenTag.
class StatusPalette {
  const StatusPalette(this.fg, this.bg, this.icon);
  final Color fg;
  final Color bg;
  final IconData icon;
}

class AppTypography {
  AppTypography._();

  /// Fraunces — гарнитура с ботаническим, слегка неровным характером,
  /// как в старых определителях растений. Используется скупо: только
  /// заголовки и крупные акценты, не для длинного текста.
  static TextTheme get textTheme => TextTheme(
        displaySmall: GoogleFonts.fraunces(
          fontSize: 30,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic,
          color: AppColors.ink,
          height: 1.15,
        ),
        headlineMedium: GoogleFonts.fraunces(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: AppColors.ink,
          height: 1.2,
        ),
        headlineSmall: GoogleFonts.fraunces(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.ink,
        ),
        titleMedium: GoogleFonts.manrope(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.ink,
        ),
        bodyLarge: GoogleFonts.manrope(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.ink,
          height: 1.4,
        ),
        bodyMedium: GoogleFonts.manrope(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: AppColors.inkMuted,
          height: 1.4,
        ),
        labelLarge: GoogleFonts.manrope(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
        labelSmall: GoogleFonts.jetBrainsMono(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.6,
          color: AppColors.inkMuted,
        ),
      );

  /// Моноширинный — для координат, id заявок, дат осмотра: подчёркивает
  /// "полевой протокол", ощущение точных данных наблюдения.
  static TextStyle mono({
    double size = 12,
    Color color = AppColors.inkMuted,
    FontWeight weight = FontWeight.w500,
  }) =>
      GoogleFonts.jetBrainsMono(
        fontSize: size,
        color: color,
        fontWeight: weight,
        letterSpacing: 0.2,
      );
}

class AppRadii {
  AppRadii._();
  static const sm = 10.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const pill = 999.0;
}

class AppSpacing {
  AppSpacing._();
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.canopy,
        primary: AppColors.canopy,
        secondary: AppColors.amber,
        surface: AppColors.birchCard,
        error: AppColors.rust,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.birch,
      textTheme: AppTypography.textTheme,
      dividerColor: AppColors.divider,
    );

    return base.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.birch,
        foregroundColor: AppColors.ink,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTypography.textTheme.headlineSmall,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: AppColors.birchCard,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
          side: const BorderSide(color: AppColors.divider),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.canopy,
          foregroundColor: AppColors.birch,
          disabledBackgroundColor: AppColors.canopy.withValues(alpha: 0.4),
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: AppTypography.textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.sm),
          ),
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.canopy,
          side: const BorderSide(color: AppColors.canopy, width: 1.4),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          textStyle: AppTypography.textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadii.sm),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.birchCard,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          borderSide: const BorderSide(color: AppColors.canopy, width: 1.6),
        ),
        hintStyle: AppTypography.textTheme.bodyMedium,
      ),
      splashFactory: InkRipple.splashFactory,
    );
  }
}
