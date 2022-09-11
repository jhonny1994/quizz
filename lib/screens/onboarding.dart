import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:quizz/constants.dart';
import 'package:quizz/screens/quiz/choosing_difficulty.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  void initState() {
    super.initState();
    clearSettings();
  }

  clearSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Text(
                'Welcome to Quizz',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: primaryColor),
              ),
            ),
            const Text(
              'Sharpen your mind and your cognitive skills. Answer multiple-choice questions and test your knowledge. Take Your First Quiz Game now.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: secondaryColor),
            ),
            const Spacer(),
            SvgPicture.asset(
              'assets/svg/question.svg',
              width: MediaQuery.of(context).size.width * 0.75,
            ),
            const Spacer(),
            StreamBuilder(
                stream: InternetConnectionChecker().onStatusChange,
                builder: (context, snapshot) {
                  final isDeviceConnected = snapshot.data;
                  if (isDeviceConnected == InternetConnectionStatus.connected) {
                    return IconButton(
                      iconSize: 64,
                      alignment: Alignment.center,
                      color: primaryColor,
                      onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const ChoosingDifficulty(),
                          ),
                          (route) => false),
                      icon: const Icon(
                        Icons.arrow_circle_right,
                      ),
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor, width: 2),
                      ),
                      child: const Text(
                        'Check your internet to start the Quizz',
                        style: TextStyle(color: secondaryColor, fontSize: 16),
                      ),
                    );
                  }
                }),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
