// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appTitle => 'நிஹோங்கோ பள்ளி';

  @override
  String get startLearning => 'கற்றலைத் தொடங்குங்கள்';

  @override
  String get selectLevel => 'உங்கள் JLPT நிலையைத் தேர்ந்தெடுக்கவும்';

  @override
  String welcomeMessage(String name) {
    return 'வரவேற்கிறோம், $name!';
  }

  @override
  String get welcomeBack => 'மீண்டும் வருக!';

  @override
  String get fullName => 'முழு பெயர்';

  @override
  String get email => 'மின்னஞ்சல்';

  @override
  String get password => 'கடவுச்சொல்';

  @override
  String get alreadyHaveAccount => 'ஏற்கனவே கணக்கு உள்ளதா? இங்கே உள்நுழையவும்';

  @override
  String get dontHaveAccount => 'கணக்கு இல்லையா? இங்கே பதிவு செய்யவும்';

  @override
  String get loginTitle => 'உங்கள் கணக்கில் உள்நுழையவும்';

  @override
  String get loginButton => 'உள்நுழைக';

  @override
  String get vocabulary => 'சொற்களஞ்சியம்';

  @override
  String get vocabSubtitle =>
      'சொற்கள் மற்றும் இலக்கணத்தைக் கற்கத் தொடங்குங்கள்';
}
