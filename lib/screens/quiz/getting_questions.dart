import 'package:flutter/material.dart';
import 'package:quizz/constants.dart';
import 'package:quizz/functions/get_questions.dart';
import 'package:quizz/models/question.dart';
import 'package:quizz/screens/quiz/quiz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GettingQuestions extends StatefulWidget {
  const GettingQuestions({super.key});

  @override
  State<GettingQuestions> createState() => _GettingQuestionsState();
}

class _GettingQuestionsState extends State<GettingQuestions> {
  Future<List<Question>> getQuestions() async {
    final prefs = await SharedPreferences.getInstance();
    final String? difficulty = prefs.getString('difficulty');
    final String? category = prefs.getString('category');
    if (difficulty != null && category != null) {
      return fetchQuestions(category: category, difficulty: difficulty);
    } else if (difficulty != null && category == null) {
      return fetchQuestions(difficulty: difficulty);
    } else if (category != null && difficulty == null) {
      return fetchQuestions(category: category);
    } else {
      return fetchQuestions();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Question>>(
      future: getQuestions(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final questions = snapshot.data;
            return StartQuiz(questions: questions);
          }
        }
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'Getting your Quizz ready',
                  style: TextStyle(
                      color: primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 7.5,
                    color: secondaryColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
