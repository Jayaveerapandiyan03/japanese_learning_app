// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Sinhala Sinhalese (`si`).
class AppLocalizationsSi extends AppLocalizations {
  AppLocalizationsSi([String locale = 'si']) : super(locale);

  @override
  String get appTitle => 'නිහොන්ගෝ පාසල';

  @override
  String get startLearning => 'ඉගෙනීම ආරම්භ කරන්න';

  @override
  String get selectLevel => 'ඔබේ JLPT මට්ටම තෝරන්න';

  @override
  String welcomeMessage(String name) {
    return 'සාදරයෙන් පිළිගනිමු, $name!';
  }

  @override
  String get welcomeBack => 'නැවත සාදරයෙන් පිළිගනිමු!';

  @override
  String get fullName => 'සම්පූර්ණ නම';

  @override
  String get email => 'විද්‍යුත් තැපෑල';

  @override
  String get password => 'මුරපදය';

  @override
  String get alreadyHaveAccount => 'දැනටමත් ගිණුමක් තිබේද? මෙතැනින් ඇතුළු වන්න';

  @override
  String get dontHaveAccount => 'ගිණුමක් නැද්ද? මෙතනින් ලියාපදිංචි වන්න';

  @override
  String get loginTitle => 'ඔබේ ගිණුමට ඇතුළු වන්න';

  @override
  String get loginButton => 'ඇතුළු වන්න';

  @override
  String get vocabulary => 'පද මාලාව';

  @override
  String get vocabSubtitle => 'වචන මාලාව සහ ව්‍යාකරණ ඉගෙනීම ආරම්භ කරන්න';

  @override
  String get grammar => 'ව්‍යාකරණ';

  @override
  String get reading => 'කියවීම';

  @override
  String get listening => 'සවන්දීම';

  @override
  String jlptLevel(Object level) {
    return 'JLPT $level';
  }
}
