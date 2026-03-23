import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _client = Supabase.instance.client;

  // Updated Sign Up: Returns a response and handles potential nulls
  Future<AuthResponse> signUp({
    required String email, 
    required String password, 
    required String name,
    required String lang,
  }) async {
    return await _client.auth.signUp(
      email: email,
      password: password,
      data: {
        'full_name': name,
        'preferred_language': lang,
      },
    );
  }

  // Sign In
  Future<AuthResponse> signIn(String email, String password) async {
    return await _client.auth.signInWithPassword(email: email, password: password);
  }

  // Sign Out (Essential for switching accounts/languages)
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  // Auth State Stream
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;
}