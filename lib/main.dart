import 'package:flutter/material.dart';
import 'package:quizz/constants.dart';
import 'package:quizz/screens/onboarding.dart';

void main() {
  runApp(const MyWidget());
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      color: primaryColor,
      debugShowCheckedModeBanner: false,
      home: Onboarding(),
    );
  }
}
