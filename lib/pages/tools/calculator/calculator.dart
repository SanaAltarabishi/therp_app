import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:multi_task_app/pages/tools/calculator/buttonCalculator.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  var userQuestion = '';
  var userAnswer = '';
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xfff3dbcc),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20,left: 20,top: 20),
                      child: Container(
                        width: 450,
                        decoration: BoxDecoration(
                            color: const Color(0xffcb8780),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0xff795a59),
                                offset: Offset(0, 2),
                                blurRadius: 5,
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(20),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  userQuestion,
                                  style: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                )),
                            Container(
                                padding: const EdgeInsets.all(20),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  userAnswer,
                                  style: const TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      ),
                    ).animate().fade(duration: .3.seconds, delay: .3.seconds),
                    Container(
                      width: 500,
                      height: 600,
                      padding: const EdgeInsets.all(20),
                      child: GridView.builder(
                        itemCount: buttons.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                        ),
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  userQuestion = '';
                                  userAnswer = '';
                                });
                              },
                              buttonText: buttons[index],
                              color: const [Color(0xffcb8780), Color(0xff795a59)],
                              textColor: Colors.white,
                            );
                          } else if (index == 1) {
                            return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  userQuestion = userQuestion.substring(
                                      0, userQuestion.length - 1);
                                  userAnswer = '';
                                });
                              },
                              buttonText: buttons[index],
                              color: const [Color(0xffcb8780), Color(0xff795a59)],
                              textColor: Colors.white,
                            );
                          } //= button
                          else if (index == buttons.length - 1) {
                            return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  userAnswer = equalPresssed();
                                });
                              },
                              buttonText: buttons[index],
                              color: const [Color(0xffcb8780), Color(0xffcb8780)],
                              textColor: Colors.white,
                            );
                          } else {
                            return MyButton(
                              buttonTapped: () {
                                setState(() {
                                  userQuestion += buttons[index];
                                });
                              },
                              buttonText: buttons[index],
                              color: isOperator(buttons[index])
                                  ? const [Color(0xffcb8780), Color(0xffcb8780)]
                                  : [
                                      Colors.deepPurple.shade50,
                                      Colors.deepPurple.shade50
                                    ],
                              textColor: isOperator(buttons[index])
                                  ? Colors.white
                                  : const Color(0xffcb8780),
                            );
                          }
                        },
                      ),
                      //  )
                    )
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Color(0xffcb8780),
              ),
            ).animate().fade(delay: .2.seconds, duration: .3.seconds),
          ],
        ),
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  equalPresssed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');
    Parser p =
        Parser(); //The Parser is responsible for parsing تحليلand interpretingتفسير mathematical expressions.
    Expression exp = p.parse(finalQuestion);
    ContextModel cn =
        ContextModel(); //ContextModel provides a context for evaluating the expression by assigning values to variables within the expression, if any.
    double eval = exp.evaluate(EvaluationType.REAL, cn);
    userAnswer = eval.toString();
    return userAnswer;
    //this code takes a mathematical expression (userQuestion), parses it using a Parser, evaluates it using an Expression, and returns the result as a string (userAnswer).
  }
}
