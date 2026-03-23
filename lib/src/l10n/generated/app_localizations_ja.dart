// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => '日本語学校';

  @override
  String get startLearning => '学習を開始する';

  @override
  String get selectLevel => 'JLPTレベルを選択してください';

  @override
  String welcomeMessage(String name) {
    return 'ようこそ、$nameさん！';
  }
}
