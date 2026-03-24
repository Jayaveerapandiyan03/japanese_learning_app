import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'exam_result_screen.dart';

class JLPTExamScreen extends StatefulWidget {
  final String level;
  const JLPTExamScreen({super.key, required this.level});

  @override
  State<JLPTExamScreen> createState() => _JLPTExamScreenState();
}

class _JLPTExamScreenState extends State<JLPTExamScreen> {
  int _currentIndex = 0;
  final Map<int, int> _userAnswers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.level} Mock Exam")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        // Junior Tip: We fetch everything marked as an exam for this level
        future: Supabase.instance.client
            .from('jlpt_content')
            .select()
            .eq('level', widget.level)
            .eq('is_exam', true),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final questions = snapshot.data!;
          if (questions.isEmpty) {
            return const Center(child: Text("No exam data found."));
          }

          final currentQ = questions[_currentIndex];
          final options = List<String>.from(currentQ['options'] ?? []);

          return Column(
            children: [
              LinearProgressIndicator(
                value: (_currentIndex + 1) / questions.length,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Question ${_currentIndex + 1}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 10),
                      // The Japanese Text from the PDF
                      Text(
                        currentQ['kana'] ?? "",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Options List
                      ...List.generate(options.length, (index) {
                        return RadioListTile<int>(
                          title: Text(options[index]),
                          value: index,
                          // ignore: deprecated_member_use
                          groupValue: _userAnswers[_currentIndex],
                          // Ignore the 'deprecated' warning for now if RadioGroup isn't set up,
                          // but ensure you use the value correctly:
                          // ignore: deprecated_member_use
                          onChanged: (int? value) {
                            setState(() {
                              _userAnswers[_currentIndex] = value!;
                            });
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
              // Navigation
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentIndex > 0)
                      TextButton(
                        onPressed: () => setState(() => _currentIndex--),
                        child: const Text("Back"),
                      ),
                    ElevatedButton(
                      onPressed: () {
                        if (_currentIndex < questions.length - 1) {
                          setState(() => _currentIndex++);
                        } else {
                          // Go to Result Screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExamResultScreen(
                                questions: questions,
                                userAnswers: _userAnswers,
                              ),
                            ),
                          );
                        }
                      },
                      child: Text(
                        _currentIndex == questions.length - 1
                            ? "Finish"
                            : "Next",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
