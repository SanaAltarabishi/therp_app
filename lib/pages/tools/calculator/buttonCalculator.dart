import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MyButton extends StatelessWidget {
  final List<Color> color;
  final Color textColor;
  final String buttonText;
  final buttonTapped;
  const MyButton(
      {super.key,
      required this.color,
      required this.textColor,
      required this.buttonText,
      this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8,
          right: 8,
          bottom: 20,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: color),
                boxShadow:const [
                  BoxShadow(
                    color: Color(0xff795a59),
                    offset: Offset(0, 2),
                    blurRadius: 5,
                  )
                ]),
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                    color: textColor,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    ).animate().fade(duration: .8.seconds, delay: .4.seconds);
  }
}
