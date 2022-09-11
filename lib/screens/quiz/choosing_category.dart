import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizz/constants.dart';
import 'package:quizz/models/categories.dart';
import 'package:quizz/screens/quiz/getting_questions.dart';
import 'package:quizz/widgets/quiz_body.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChoosingCategory extends StatefulWidget {
  const ChoosingCategory({super.key});

  @override
  State<ChoosingCategory> createState() => _ChoosingCategoryState();
}

class _ChoosingCategoryState extends State<ChoosingCategory> {
  int? _selectedIndex;
  String? _selectedOption;

  setCategory(String category) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('category', category);
    Future.delayed(
      Duration.zero,
      () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const GettingQuestions(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QuizPageStructure(
      actionButton: _selectedIndex != null
          ? FloatingActionButton(
              onPressed: () => _selectedOption != null
                  ? setCategory(_selectedOption!)
                  : Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const GettingQuestions(),
                      ),
                    ),
              backgroundColor: primaryColor,
              child: const Icon(Icons.arrow_forward_ios, size: 20),
            )
          : null,
      headline: 'Choose a category',
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return categoryContainer(
              index: index,
              name: categories.keys.elementAt(index),
              category: categories.values.elementAt(index));
        },
      ),
    );
  }

  categoryContainer({required String name, String? category, int? index}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedIndex == index || index == null) {
            _selectedIndex = null;
            _selectedOption = null;
          } else {
            _selectedIndex = index;
            _selectedOption = category;
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: _selectedIndex == index ? secondaryColor : backgroundColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgPicture.asset(
            category == null
                ? 'assets/svg/general.svg'
                : 'assets/svg/$category.svg',
            height: 80,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 16,
              color: _selectedIndex == index ? secondaryColor : textColor,
            ),
          )
        ]),
      ),
    );
  }
}
