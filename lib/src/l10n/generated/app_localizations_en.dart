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

  @override
  String get welcomeBack => 'Welcome back!';

  @override
  String get fullName => 'Full Name';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get alreadyHaveAccount => 'Already have an account? Login here';

  @override
  String get dontHaveAccount => 'Don\'t have an account? Sign up here';

  @override
  String get loginTitle => 'Login to Your Account';

  @override
  String get loginButton => 'Login';

  @override
  String get vocabulary => 'Vocabulary';

  @override
  String get vocabSubtitle => 'Start learning vocabulary & grammar';

  @override
  String get grammar => 'Grammar';

  @override
  String get reading => 'Reading';

  @override
  String get listening => 'Listening';

  @override
  String jlptLevel(Object level) {
    return 'JLPT $level';
  }
}
