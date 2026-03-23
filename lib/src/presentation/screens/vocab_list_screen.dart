import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../l10n/generated/app_localizations.dart';

class VocabListScreen extends StatelessWidget {
  final String level; // e.g., 'N5'

  const VocabListScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    // 1. Get the current localization instance
    final l10n = AppLocalizations.of(context)!;
    
    // 2. Get the current language code (en, ta, si, or ja)
    final String languageCode = Localizations.localeOf(context).languageCode;

    return Scaffold(
      // 3. Localized Title: Uses a placeholder if you define it in ARB, 
      // or simply combines level + localized word
      appBar: AppBar(title: Text("$level ${l10n.vocabulary}")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: Supabase.instance.client
            .from('jlpt_content')
            .select()
            .eq('level', level)
            .eq('category', 'vocab'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data found"));
          }
          
          final vocabItems = snapshot.data!;

          return ListView.builder(
            itemCount: vocabItems.length,
            itemBuilder: (context, index) {
              final item = vocabItems[index];
              final translations = item['translations'] as Map<String, dynamic>;
              
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(
                    "${item['kanji'] ?? item['kana']} (${item['romaji']})",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['kana'], style: const TextStyle(color: Colors.grey)),
                      // The translation automatically switches based on Mother Tongue
                      Text(
                        translations[languageCode] ?? translations['en'], 
                        style: const TextStyle(
                          color: Colors.indigo, 
                          fontSize: 16, 
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}