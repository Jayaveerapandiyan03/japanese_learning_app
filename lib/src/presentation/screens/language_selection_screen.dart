import 'package:flutter/material.dart';
import 'package:japanese_learning_app/main.dart'; // To access appLocale
import 'signup_screen.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  void _onLanguageSelected(BuildContext context, String langCode) {
    // 1. Set the global locale immediately
    appLocale.value = Locale(langCode);
    
    // 2. Navigate to Signup - everything will now be in the chosen language
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const SignupScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.translate, size: 80, color: Colors.indigo),
              const SizedBox(height: 24),
              const Text(
                "Choose Your Language",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 48),
              _langButton(context, "English", "en"),
              _langButton(context, "தமிழ் (Tamil)", "ta"),
              _langButton(context, "සිංහල (Sinhala)", "si"),
              _langButton(context, "日本語 (Japanese)", "ja"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _langButton(BuildContext context, String label, String code) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.indigo, width: 2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () => _onLanguageSelected(context, code),
          child: Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.indigo),
          ),
        ),
      ),
    );
  }
}