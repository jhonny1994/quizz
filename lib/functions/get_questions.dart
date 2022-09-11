import 'package:http/http.dart' as http;
import 'package:quizz/models/question.dart';

Future<List<Question>> testQuestions({
  String? numberOfQuestions,
  String? category,
  String? difficulty,
}) async {
  const String url = 'https://the-trivia-api.com/api/questions?limit=2';
  final response = await http.get(Uri.parse(url));
  return questionFromJson(response.body);
}

Future<List<Question>> fetchQuestions({
  String? numberOfQuestions,
  String? category,
  String? difficulty,
}) async {
  const String url = 'the-trivia-api.com';

  if (category != null && numberOfQuestions != null && difficulty != null) {
    final response = await http.get(Uri.https(url, 'api/questions', {
      'categories': category,
      'limit': numberOfQuestions.toString(),
      'difficulty': difficulty,
    }));

    return questionFromJson(response.body);
  } else if (category != null &&
      numberOfQuestions == null &&
      difficulty == null) {
    final response = await http.get(Uri.https(url, 'api/questions', {
      'categories': category,
    }));

    return questionFromJson(response.body);
  } else if (category == null &&
      numberOfQuestions != null &&
      difficulty == null) {
    final response = await http.get(Uri.https(url, 'api/questions', {
      'limit': numberOfQuestions.toString(),
    }));

    return questionFromJson(response.body);
  } else if (category == null &&
      numberOfQuestions == null &&
      difficulty != null) {
    final response = await http.get(Uri.https(url, 'api/questions', {
      'difficulty': difficulty,
    }));

    return questionFromJson(response.body);
  } else if (category != null &&
      numberOfQuestions != null &&
      difficulty == null) {
    final response = await http.get(Uri.https(url, 'api/questions', {
      'categories': category,
      'limit': numberOfQuestions.toString(),
    }));

    return questionFromJson(response.body);
  } else if (category == null &&
      numberOfQuestions != null &&
      difficulty != null) {
    final response = await http.get(Uri.https(url, 'api/questions', {
      'limit': numberOfQuestions.toString(),
      'difficulty': difficulty,
    }));

    return questionFromJson(response.body);
  } else if (category != null &&
      numberOfQuestions == null &&
      difficulty != null) {
    final response = await http.get(Uri.https(url, 'api/questions', {
      'categories': category,
      'difficulty': difficulty,
    }));

    return questionFromJson(response.body);
  } else {
    final response = await http.get(Uri.https(url, 'api/questions'));

    return questionFromJson(response.body);
  }
}
