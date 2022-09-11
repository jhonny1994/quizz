import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:quizz/constants.dart';

class QuizPageStructure extends StatelessWidget {
  final FloatingActionButton? actionButton;

  final Widget body;
  final String headline;
  final String? smallText;
  const QuizPageStructure(
      {super.key,
      required this.actionButton,
      this.smallText,
      required this.headline,
      required this.body});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: const Text('Quizz'),
        centerTitle: true,
      ),
      floatingActionButton: actionButton,
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: size.height * 0.2,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5))),
                  height: size.height * 0.125,
                  child: smallText != null
                      ? Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: size.height * 0.075,
                                  left: 16,
                                  right: 16),
                              child: Text(
                                smallText!,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: secondaryColor,
                                ),
                              ),
                            ),
                          ],
                        )
                      : null,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            color: backgroundColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: size.height * 0.15,
                        child: Center(
                          child: AutoSizeText(
                            headline,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: body,
            ),
          ),
        ],
      )),
    );
  }
}
