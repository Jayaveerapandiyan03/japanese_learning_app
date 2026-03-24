import 'package:flutter/material.dart';

class ExamResultScreen extends StatelessWidget {
  final List<Map<String, dynamic>> questions;
  final Map<int, int> userAnswers;

  const ExamResultScreen({super.key, required this.questions, required this.userAnswers});

  @override
  Widget build(BuildContext context) {
    int score = 0;
    // Calculate Score
    for (int i = 0; i < questions.length; i++) {
      if (userAnswers[i] != null && (userAnswers[i]! + 1) == questions[i]['correct_option']) {
        score++;
      }
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.stars, size: 100, color: Colors.orange),
            const SizedBox(height: 20),
            Text("Exam Complete!", style: Theme.of(context).textTheme.headlineMedium),
            Text("Your Score: $score / ${questions.length}", style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text("Return to Home"),
            )
          ],
        ),
      ),
    );
  }
}