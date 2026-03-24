import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../l10n/generated/app_localizations.dart';

class VocabListScreen extends StatelessWidget {
  final String level;
  final String category; // 'vocab', 'grammar', 'reading', 'listening'

  const VocabListScreen({
    super.key,
    required this.level,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final String languageCode = Localizations.localeOf(context).languageCode;
    final l10n = AppLocalizations.of(context)!;

    // Dynamic Title based on category
    String getTitle() {
      if (category == 'vocab') return l10n.vocabulary;
      if (category == 'grammar') return l10n.grammar;
      if (category == 'reading') return l10n.reading;
      if (category == 'listening') return l10n.listening;
      return category.toUpperCase();
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text("$level ${getTitle()}"),
        elevation: 0,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: Supabase.instance.client
            .from('jlpt_content')
            .select()
            .eq('level', level)
            .eq('category', category),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final items = snapshot.data ?? [];

          if (items.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.engineering_outlined, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    "Lessons for $category are coming soon!",
                    style: const TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: items.length,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            itemBuilder: (context, index) {
              final item = items[index];
              final translations = item['translations'] as Map<String, dynamic>;
              final String meaning = translations[languageCode] ?? translations['en'] ?? "";

              // UI Routing logic
              switch (category) {
                case 'vocab':
                  return _buildVocabTile(item, meaning);
                case 'grammar':
                  return _buildGrammarTile(item, meaning);
                case 'reading':
                  return _buildReadingTile(item, meaning);
                case 'listening':
                  return _buildListeningTile(item, meaning);
                default:
                  return _buildVocabTile(item, meaning);
              }
            },
          );
        },
      ),
    );
  }

  // --- UI WIDGETS ---

  Widget _buildVocabTile(Map item, String meaning) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        title: Text(
          item['kanji'] ?? item['kana'],
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          item['romaji'] ?? "",
          style: TextStyle(color: Colors.grey[600], fontSize: 14),
        ),
        trailing: Text(
          meaning,
          style: const TextStyle(color: Colors.indigo, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildGrammarTile(Map item, String meaning) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item['kana'] ?? "",
              style: const TextStyle(fontSize: 22, color: Colors.blueAccent, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(meaning, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const Divider(height: 24),
            const Text("Example / 例文:", style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(
              item['example_ja'] ?? "例文なし",
              style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReadingTile(Map item, String meaning) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ExpansionTile(
        leading: const Icon(Icons.menu_book, color: Colors.green),
        title: Text(
          item['kana'] ?? "Reading Title",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(meaning),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              item['content'] ?? "",
              style: const TextStyle(fontSize: 16, height: 1.6, letterSpacing: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListeningTile(Map item, String meaning) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                backgroundColor: Colors.purple.withValues(alpha: 0.1),
                  child: const Icon(Icons.headset, color: Colors.purple),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item['kana'] ?? "Listening Lesson",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              meaning,
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                // Future: Implement Audio Player logic here
              },
              icon: const Icon(Icons.play_circle_fill),
              label: const Text("Play Audio Clip"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}