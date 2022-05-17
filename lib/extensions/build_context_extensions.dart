part of './extensions.dart';

extension BuildContextExtensions on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
  ThemeData get theme => Theme.of(this);
  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(this);
}
