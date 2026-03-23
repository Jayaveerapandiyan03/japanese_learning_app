import 'package:flutter/material.dart';
import 'package:japanese_learning_app/src/presentation/screens/language_selection_screen.dart';
import 'package:japanese_learning_app/src/presentation/screens/level_selection_screen.dart'; // Ensure this is imported
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final session = snapshot.data?.session;

        // If logged in, go to Level Selection
        if (session != null) {
          return const LevelSelectionScreen();
        }

        // If logged out, go to Language Selection (Mother Tongue First)
        return const LanguageSelectionScreen();
      },
    );
  }
}