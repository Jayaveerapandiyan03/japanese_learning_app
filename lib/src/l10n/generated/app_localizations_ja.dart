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

  @override
  String get welcomeBack => 'おかえりなさい！';

  @override
  String get fullName => '氏名';

  @override
  String get email => 'メールアドレス';

  @override
  String get password => 'パスワード';

  @override
  String get alreadyHaveAccount => 'すでにアカウントをお持ちですか？こちらからログイン';

  @override
  String get dontHaveAccount => 'アカウントをお持ちでないですか？新規登録';

  @override
  String get loginTitle => 'アカウントにログイン';

  @override
  String get loginButton => 'ログイン';

  @override
  String get vocabulary => '単語';

  @override
  String get vocabSubtitle => '単語と文法の学習を始める';
}
