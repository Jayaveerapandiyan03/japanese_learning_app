// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Burmese (`my`).
class AppLocalizationsMy extends AppLocalizations {
  AppLocalizationsMy([String locale = 'my']) : super(locale);

  @override
  String get appTitle => 'ဂျပန်စာသင်ကျောင်း';

  @override
  String get startLearning => 'သင်ခန်းစာစတင်ရန်';

  @override
  String get selectLevel => 'JLPT အဆင့်ကိုရွေးချယ်ပါ';

  @override
  String welcomeMessage(String name) {
    return 'မင်္ဂလာပါ $name!';
  }
}
