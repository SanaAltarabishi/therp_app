import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_task_app/core/get_it.dart';
import 'package:multi_task_app/pages/3dDrawer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
       const Duration(seconds: 3),
        () => Navigator.push(
            context,
            PageTransition(
                child:const DrawerPage(), type: PageTransitionType.fade)));
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:const Color(0xfff3dbcc),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration:const BoxDecoration(
                shape: BoxShape.circle,
              ),
              width: 300,
              height: 300,
              child: ClipOval(
                child: Image.asset(
                  'images/wave (2).png',
                  fit: BoxFit.cover,
                ),
              ),
            )
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .moveY(
                  begin: -25,
                  end: 15,
                  curve: Curves.easeInOut,
                  duration:const Duration(
                    milliseconds: 1000,
                  ),
                )
                .then()
                .moveY(
                  begin: 15,
                  end: -25,
                  curve: Curves.easeInOut,
                ),
            Padding(
              padding:const EdgeInsets.only(
                top: 10,
              ),
              child: Container(
                width: 150,
                height: 15,
                decoration: BoxDecoration(
                  color:const Color(0xff795a59).withOpacity(0.2),
                  borderRadius:const
                   BorderRadius.all(
                    Radius.elliptical(100, 10),
                  ),
                ),
              ),
            )
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .scaleX(
                  begin: 1.2,
                  end: .8,
                  curve: Curves.easeInOut,
                  duration:const Duration(milliseconds: 1000),
                )
                .then()
                .scaleX(
                  begin: .8,
                  end: 1.2,
                  curve: Curves.easeInOut,
                ),
           const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "W",
                  style: GoogleFonts.bagelFatOne(
                    fontSize: screenWidth / 9,
                    color:const Color(0xff795a59),
                  ),
                ),
                Text(
                  "e",
                  style: GoogleFonts.bagelFatOne(
                    fontSize: screenWidth / 9,
                    color:const Color(0xffcb8780),
                  ),
                ),
                Text(
                  "l",
                  style: GoogleFonts.bagelFatOne(
                    fontSize: screenWidth / 9,
                    color:const Color(0xffa36168),
                  ),
                ),
                Text(
                  "c",
                  style: GoogleFonts.bagelFatOne(
                    fontSize: screenWidth / 9,
                    color:const Color(0xff7a6c5b),
                  ),
                ),
                Text(
                  "o",
                  style: GoogleFonts.bagelFatOne(
                    fontSize: screenWidth / 9,
                    color:const Color(0xffa96054),
                  ),
                ),
                Text(
                  "m",
                  style: GoogleFonts.bagelFatOne(
                    fontSize: screenWidth / 9,
                    color:const Color(0xff5c666c),
                  ),
                ),
                Text(
                  "e ",
                  style: GoogleFonts.bagelFatOne(
                    fontSize: screenWidth / 9,
                    color:const Color(0xff795a59),
                  ),
                ),
                Text(
                  "${getIt.get<SharedPreferences>().getString('user_name') ?? ''}",
                  style: GoogleFonts.bagelFatOne(
                    fontSize: screenWidth / 9,
                    color:const Color(0xff795a59),
                  ).copyWith(decoration: TextDecoration.underline,decorationColor:const Color(0xff795a59), ),
                ),
              ],
            ).animate().fadeIn(delay: 200.ms, duration: .3.seconds),
          const  SizedBox(
              height: 20,
            ),
            Text(
              "Enjoy while discovering the application",
              style: GoogleFonts.bagelFatOne(
                fontSize: screenWidth / 30,
                color:const Color(0xff795a59),
              ),
            ).animate().fadeIn(delay: 400.ms, duration: .5.seconds),
          ],
        ),
      ),
    );
  }
}
