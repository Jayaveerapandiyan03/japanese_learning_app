// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Nihongo School';

  @override
  String get startLearning => 'Start Learning';

  @override
  String get selectLevel => 'Select JLPT Level';

  @override
  String welcomeMessage(String name) {
    return 'Welcome, $name!';
  }
}
