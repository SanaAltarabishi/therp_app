import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_task_app/core/get_it.dart';
import 'package:multi_task_app/pages/welcome_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

final _usernameController = TextEditingController();

class ValidateScreen extends StatelessWidget {
  const ValidateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color baseColor = Color(0xfff3dbcc);
    final Color secColor = Color(0xff795a59);
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: baseColor,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
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
                        color: const Color(0xff7a6c5b),
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
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            Positioned(
              top: screenHeight * .1,
              left: screenWidth / 5,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: secColor,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  color: baseColor.withOpacity(0.7),
                ),
                width: screenWidth * .6,
                height: screenHeight * .6,
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'WELCOME TO',
                              style: GoogleFonts.arOneSans(
                                color: const Color(0xff795a59),
                                fontSize: screenWidth / 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' T',
                              style: GoogleFonts.arOneSans(
                                color: const Color(0xffcb8780),
                                fontSize: screenWidth / 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'H',
                              style: GoogleFonts.arOneSans(
                                color: const Color(0xffa36168),
                                fontSize: screenWidth / 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'E',
                              style: GoogleFonts.arOneSans(
                                color: const Color(0xff7a6c5b),
                                fontSize: screenWidth / 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'R',
                              style: GoogleFonts.arOneSans(
                                color: const Color(0xffa96054),
                                fontSize: screenWidth / 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'P',
                              style: GoogleFonts.arOneSans(
                                color: const Color(0xff5c666c),
                                fontSize: screenWidth / 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' APP',
                              style: GoogleFonts.arOneSans(
                                color: secColor,
                                fontSize: screenWidth / 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                            .animate()
                            .fadeIn(delay: .8.seconds, duration: .5.seconds),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: Text(
                            'Fill out the following sections,please..',
                            style: TextStyle(
                              color: secColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(delay: 1.seconds, duration: .7.seconds),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            controller: _usernameController,
                            cursorColor: secColor,
                            decoration: InputDecoration(
                              hintText: 'User name',
                              prefixIcon: const Icon(Icons.person_2_rounded),
                              prefixIconColor: secColor,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: secColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  width: 3,
                                  color: secColor,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              } else {
                                return null;
                              }
                            },
                          ),
                        )
                            .animate()
                            .fadeIn(delay: 1.2.seconds, duration: .9.seconds),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              if (value.length < 8) {
                                return 'Password must be at least 8 characters long';
                              }
                              return null;
                            },
                            obscureText: true,
                            cursorColor: secColor,
                            decoration: InputDecoration(
                              prefixIconColor: secColor,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: secColor,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    width: 3,
                                    color: secColor,
                                  )),
                              hintText: 'Password',
                              prefixIcon: const Icon(Icons.password),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(delay: 1.4.seconds, duration: 1.1.seconds),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            color: secColor,
                            minWidth: screenWidth,
                            height: 50,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            onPressed: () {
                                  getIt.get<SharedPreferences>().setString('user_name', _usernameController.text);
                              if (_formKey.currentState!.validate()) {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        child:const WelcomeScreen(),
                                        type: PageTransitionType.fade));
                              }
                            },
                            child: const Text(
                              'JOIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(delay: 1.6.seconds, duration: 1.3.seconds),
                      ],
                    ),
                  ),
                ),
              ),
            ).animate().fadeIn(delay: .6.seconds, duration: .3.seconds),
          ],
        ),
      ),
    );
  }
}
