part of 'extensions.dart';

extension ThemeModeExtension on ThemeMode {
  String l10n(BuildContext context) {
    switch (this) {
      case ThemeMode.dark:
        return context.l10n.dark;
      case ThemeMode.light:
        return context.l10n.light;
      case ThemeMode.system:
        return context.l10n.system;
    }
  }
}
