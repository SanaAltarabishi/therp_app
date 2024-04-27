import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_task_app/pages/validate_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
 const SplashScreen({super.key});

  @override 
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Color baseColor =const Color(0xfff3dbcc);

  @override
  void initState() {
    super.initState();
    Timer(
       const Duration(seconds: 2),
        () => Navigator.push(
            context,
            PageTransition(
                child:const ValidateScreen(), type: PageTransitionType.fade)));
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: baseColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: screenWidth / 0.5,
                height: screenHeight / 1.3,
                child: Image.asset(
                  'images/therp.jpg',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'T',
                  style: GoogleFonts.bagelFatOne(
                    fontSize: screenWidth / 9,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffcb8780),
                  ),
                ),
                Text(
                  ' H',
                  style: GoogleFonts.bagelFatOne(
                    fontSize: screenWidth / 9,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffa36168),
                  ),
                ),
                Text(
                  ' E',
                  style: GoogleFonts.bagelFatOne(
                    fontSize: screenWidth / 9,
                    fontWeight: FontWeight.bold,
                    color:const Color(0xff7a6c5b)
                    // const Color(0xffa5a4a3),
                  ),
                ),
                Text(
                  ' R',
                  style: GoogleFonts.bagelFatOne(
                    fontSize: screenWidth / 9,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffa96054),
                  ),
                ),
                Text(
                  ' P',
                  style: GoogleFonts.bagelFatOne(
                    fontSize: screenWidth / 9,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff5c666c),
                  ),
                ),
              ],
            ).animate().shake(duration: .9.seconds),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
