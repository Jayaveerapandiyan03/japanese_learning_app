import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

// Import your screens and localizations
import 'src/presentation/screens/auth_wrapper.dart';
import 'src/l10n/generated/app_localizations.dart';

// Global Notifier for Language Switching
final ValueNotifier<Locale> appLocale = ValueNotifier(const Locale('en'));

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Load Environment Variables
  await dotenv.load(fileName: ".env");

  // 2. Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  runApp(const ProviderScope(child: NihongoSchoolApp()));
}

class NihongoSchoolApp extends StatelessWidget {
  const NihongoSchoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    // We wrap MaterialApp with ValueListenableBuilder to rebuild on language change
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocale,
      builder: (context, currentLocale, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'JLPT School',
          
          // 1. Set the current locale
          locale: currentLocale,

          // 2. Localization Config
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('ja'), // Japanese
            Locale('ta'), // Tamil
            Locale('si'), // Sinhala
          ],

          // 3. Theme Engine with Dynamic Fonts
          theme: ThemeData(
            colorSchemeSeed: Colors.indigo,
            useMaterial3: true,
            // Pass the currentLocale to the theme builder
            textTheme: _buildTextTheme(currentLocale.languageCode),
          ),
          
          home: const AuthWrapper(),
        );
      },
    );
  }

  /// Senior Guidance: Dynamic Font Selection for JLPT Scripts
  /// Ensures Tamil and Sinhala characters render beautifully.
  TextTheme _buildTextTheme(String languageCode) {
    switch (languageCode) {
      case 'ja':
        return GoogleFonts.notoSansJpTextTheme();
      case 'ta':
        return GoogleFonts.notoSansTamilTextTheme();
      case 'si':
        return GoogleFonts.notoSansSinhalaTextTheme();
      default:
        return GoogleFonts.robotoTextTheme();
    }
  }
}