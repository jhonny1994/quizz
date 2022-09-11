import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quizz/constants.dart';
import 'package:quizz/models/question.dart';
import 'package:quizz/screens/onboarding.dart';
import 'package:quizz/widgets/quiz_body.dart';

class StartQuiz extends StatefulWidget {
  final List<Question> questions;

  const StartQuiz({super.key, required this.questions});

  @override
  State<StartQuiz> createState() => _StartQuizState();
}

class _StartQuizState extends State<StartQuiz> {
  late PageController _controller;
  String? _selectedOption;
  int _selectedQuestion = 0;

  Widget answerWidget(String option, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedOption == option) {
            _selectedOption = null;
          } else {
            _selectedOption = option;
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
            color: _selectedOption == option ? secondaryColor : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  option,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              _selectedOption != option
                  ? const Icon(Icons.circle_outlined, color: secondaryColor)
                  : const Icon(Icons.circle_rounded, color: primaryColor),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return QuizPageStructure(
      actionButton: _selectedOption != null
          ? _selectedQuestion != widget.questions.length - 1
              ? FloatingActionButton(
                  onPressed: () async {
                    if (widget.questions[_selectedQuestion].correctAnswer ==
                        _selectedOption) {
                      QuickAlert.show(
                        barrierDismissible: false,
                        context: context,
                        type: QuickAlertType.success,
                        text: 'Your answer is correct',
                        onConfirmBtnTap: () {
                          _controller.nextPage(
                            duration: const Duration(microseconds: 250),
                            curve: Curves.easeInExpo,
                          );
                          setState(() {
                            _selectedQuestion++;
                            _selectedOption = null;
                          });
                          Navigator.pop(context);
                        },
                      );
                    } else {
                      QuickAlert.show(
                        barrierDismissible: false,
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Try again',
                        text: 'Your answer is not correct',
                      );
                    }
                  },
                  backgroundColor: primaryColor,
                  child: const Icon(Icons.arrow_forward_ios, size: 20),
                )
              : FloatingActionButton(
                  onPressed: () {
                    if (widget.questions[_selectedQuestion].correctAnswer ==
                        _selectedOption) {
                      QuickAlert.show(
                        barrierDismissible: false,
                        context: context,
                        type: QuickAlertType.success,
                        text: 'Your answer is correct',
                        onConfirmBtnTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const Onboarding(),
                              ),
                              (route) => false);
                        },
                      );
                    } else {
                      QuickAlert.show(
                        barrierDismissible: false,
                        context: context,
                        type: QuickAlertType.error,
                        title: 'Try again',
                        text: 'Your answer is not correct',
                      );
                    }
                  },
                  backgroundColor: primaryColor,
                  child: const Icon(Icons.done, size: 20),
                )
          : null,
      smallText:
          'Question ${_selectedQuestion + 1} of ${widget.questions.length}',
      headline: widget.questions[_selectedQuestion].question,
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.questions.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final question = widget.questions[index];
          final options = question.options;
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      return answerWidget(question.options[index], index);
                    }),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }
}
