import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:multi_task_app/container_model.dart';
import 'package:page_transition/page_transition.dart';

class ContainerData extends StatelessWidget {
  const ContainerData({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.data,
    required this.index,
  });

  final double screenWidth;
  final double screenHeight;
  final ContainerModel data;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: GestureDetector(
        onTap: () {
          //navigate
          Navigator.push(
              context,
              PageTransition(
                  child: data.navigate, type: PageTransitionType.fade));
        },
        child: Container(
          margin:
              const EdgeInsets.only(right: 25, left: 25, bottom: 40, top: 10),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: data.color,
                offset: const Offset(2, 2),
                blurRadius: 5,
                spreadRadius: 0,
              ),
            ],
            borderRadius: BorderRadius.circular(20),
            color: data.color,
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    data.image,
                    // height: screenHeight * 0.30,
                    // width: screenWidth * 0.40,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  data.text,
                  style: TextStyle(
                      color: data.color,
                      fontSize: screenWidth / 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ).animate().fadeIn(delay: .4.seconds, duration: .5.seconds,curve: Curves.ease),
      ),
    );
  }
}
