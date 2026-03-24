import 'package:flutter/material.dart';
import 'package:japanese_learning_app/src/presentation/screens/exam/jlpt_exam_screen.dart';
import 'vocab_list_screen.dart';
import '../../l10n/generated/app_localizations.dart';
import 'exam/jlpt_exam_screen.dart';

class LevelCategoryScreen extends StatelessWidget {
  final String level;

  const LevelCategoryScreen({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final List<Map<String, dynamic>> categories = [
      {
        'id': 'vocab',
        'title': l10n.vocabulary,
        'icon': Icons.translate,
        'color': Colors.orange,
      },
      {
        'id': 'grammar',
        'title': l10n.grammar,
        'icon': Icons.history_edu,
        'color': Colors.blue,
      },
      {
        'id': 'reading',
        'title': l10n.reading,
        'icon': Icons.menu_book,
        'color': Colors.green,
      },
      {
        'id': 'listening',
        'title': l10n.listening,
        'icon': Icons.headset,
        'color': Colors.purple,
      },
      {
        'id': 'exam',
        'title': 'Mock Exam', // Add this to your .arb files later
        'icon': Icons.assignment_turned_in,
        'color': Colors.redAccent,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text(
          "JLPT $level",
        ), // Or use l10n.jlptLevel(level) if metadata is set
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.0,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final cat = categories[index];
            return InkWell(
              onTap: () {
                if (cat['id'] == 'exam') {
                  // Navigate to the Exam Logic
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JLPTExamScreen(level: level),
                    ),
                  );
                } else {
                  // Normal lesson list logic
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VocabListScreen(level: level, category: cat['id']),
                    ),
                  );
                }
              },
              child: Card(
                elevation: 4,
                shadowColor: cat['color'].withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: cat['color'].withOpacity(0.1),
                      child: Icon(cat['icon'], size: 30, color: cat['color']),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      cat['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
