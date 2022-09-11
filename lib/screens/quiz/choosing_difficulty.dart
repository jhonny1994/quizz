import 'package:flutter/material.dart';
import 'package:quizz/constants.dart';
import 'package:quizz/models/difficulties.dart';
import 'package:quizz/screens/quiz/choosing_category.dart';
import 'package:quizz/widgets/quiz_body.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChoosingDifficulty extends StatefulWidget {
  const ChoosingDifficulty({super.key});

  @override
  State<ChoosingDifficulty> createState() => _ChoosingDifficultyState();
}

class _ChoosingDifficultyState extends State<ChoosingDifficulty> {
  String? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return QuizPageStructure(
      actionButton: FloatingActionButton(
        onPressed: () => _selectedOption != null
            ? setDifficulty(_selectedOption!)
            : Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ChoosingCategory(),
                ),
              ),
        backgroundColor: primaryColor,
        child: const Icon(Icons.arrow_forward_ios, size: 20),
      ),
      headline: 'Choose your level',
      body: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: difficulties.length,
          itemBuilder: (BuildContext context, int index) {
            final value = difficulties.values.elementAt(index);
            final key = difficulties.keys.elementAt(index);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (_selectedOption == value) {
                    _selectedOption = null;
                  } else {
                    _selectedOption = value;
                  }
                });
              },
              child: Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                    color: _selectedOption == value ? secondaryColor : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          key,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      _selectedOption != value
                          ? const Icon(Icons.circle_outlined,
                              color: secondaryColor)
                          : const Icon(Icons.circle_rounded,
                              color: primaryColor),
                    ],
                  )),
            );
          }),
    );
  }

  setDifficulty(String difficulty) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('difficulty', difficulty);
    Future.delayed(
      Duration.zero,
      () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ChoosingCategory(),
        ),
      ),
    );
  }
}
