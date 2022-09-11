// To parse this JSON data, do
//
//     final question = questionFromJson(jsonString);

import 'dart:convert';

List<String> getAnswers(Map<String, dynamic> json) {
  List<String> answersList = [];

  answersList = List<String>.from(json["incorrectAnswers"].map((x) => x));
  answersList.add(json["correctAnswer"]);
  answersList.shuffle();
  return answersList;
}

List<Question> questionFromJson(String str) =>
    List<Question>.from(json.decode(str).map((x) => Question.fromJson(x)));

class Question {
  String category;

  String id;
  String correctAnswer;
  List<String> options;
  String question;
  String? difficulty;
  Question({
    required this.category,
    required this.id,
    required this.correctAnswer,
    required this.options,
    required this.question,
    this.difficulty,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        category: json["category"],
        id: json["id"],
        correctAnswer: json["correctAnswer"],
        options: getAnswers(json),
        question: json["question"],
        difficulty: json["difficulty"],
      );
}
