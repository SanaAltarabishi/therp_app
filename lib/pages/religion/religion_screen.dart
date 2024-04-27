
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_task_app/container_model.dart';
import 'package:multi_task_app/pages/containerDataWidget.dart';


class ReligionScreen extends StatelessWidget {
  const ReligionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xfff3dbcc),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Center(
              child: Text(
                'Religion',
                style: GoogleFonts.bagelFatOne(
                  fontSize: screenWidth / 12,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xffa96054),
                ),
              ).animate(onPlay:(controller) => controller.repeat(),).shimmer(duration: 2.seconds),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
                width: screenWidth,
                height: screenHeight * 0.8,
                child: GridView.builder(
                  itemCount: religionData.length, //toolData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return ContainerData(
                      screenWidth: screenWidth,
                      screenHeight: screenHeight,
                      index: index,
                      data: religionData[index],
                    ).animate().fadeIn(delay: .2.seconds, duration: .7.seconds);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
