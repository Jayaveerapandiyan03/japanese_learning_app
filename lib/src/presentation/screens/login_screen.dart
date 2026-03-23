import 'package:flutter/material.dart';
import 'package:japanese_learning_app/src/presentation/screens/auth_wrapper.dart';
import 'package:japanese_learning_app/src/presentation/screens/signup_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:japanese_learning_app/main.dart';
import '../../l10n/generated/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // FIX: Removed 'dynamic l10n' parameter. 
  // Buttons require a VoidCallback (a function with no arguments).
  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);
    
    // We get l10n inside the method instead of passing it as an argument
    final l10n = AppLocalizations.of(context)!;

    try {
      final AuthResponse res = await Supabase.instance.client.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final user = res.user;
      if (user != null) {
        final data = await Supabase.instance.client
            .from('profiles')
            .select('preferred_language')
            .eq('id', user.id)
            .single();

        final String lang = data['preferred_language'] ?? 'en';
        appLocale.value = Locale(lang);

        if (!mounted) return;

        // FIX: Added the missing localized string to the Text widget
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.welcomeBack), 
            backgroundColor: Colors.green,
          ),
        );

        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const AuthWrapper()),
          (route) => false,
        );
      }
    } on AuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message), backgroundColor: Colors.red),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An unexpected error occurred")),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              l10n.loginTitle,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 32),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: l10n.email,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: l10n.password,
                border: const OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 32),
            _isLoading
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _handleLogin, 
                      child: Text(l10n.loginButton),
                    ),
                  ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const SignupScreen()),
              ),
              child: Text(l10n.dontHaveAccount),
            ),
          ],
        ),
      ),
    );
  }
}