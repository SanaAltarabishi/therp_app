import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_task_app/pages/entertainment/xo_game/game_page.dart';
import 'package:page_transition/page_transition.dart';

class XOHomepage extends StatefulWidget {
  const XOHomepage({super.key});

  @override
  State<XOHomepage> createState() => _XOHomepageState();
}

class _XOHomepageState extends State<XOHomepage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController player1Controller = TextEditingController();
  final TextEditingController player2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xfff3dbcc),
      body: Stack(
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter Players name ',
                  style: GoogleFonts.bagelFatOne(
                    fontSize: screenWidth / 15,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff7a6c5b),
                  ),
                  // style:
                  //  TextStyle(
                  //   fontSize: 30,
                  //   fontWeight: FontWeight.bold,
                  //   color: Color(0xff7a6c5b),
                  // ),
                ).animate().fade(delay: .4.seconds, duration: .5.seconds),
             const   SizedBox(
                  height: 20,
                ),
                Padding(
                  padding:const EdgeInsets.all(15),
                  child: TextFormField(
                    cursorColor:const Color(0xff7a6c5b),
                    controller: player1Controller,
                    style:const TextStyle(
                      color: Color(0xff7a6c5b),
                    ),
                    decoration:const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff7a6c5b),
                            width: 3,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 3),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xff7a6c5b),
                        )),
                        hintText: 'player 1 name',
                        hintStyle: TextStyle(
                          color: Color(0xff7a6c5b),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter player 1 name';
                      }
                      return null;
                    },
                  ),
                ).animate().fade(delay: .6.seconds, duration: .7.seconds),
              const  SizedBox(
                  height: 10,
                ),
                Padding(
                  padding:const EdgeInsets.all(15),
                  child: TextFormField(
                    cursorColor:const Color(0xff7a6c5b),
                    controller: player2Controller,
                    style:const TextStyle(
                      color: Color(0xff7a6c5b),
                    ),
                    decoration:const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xff7a6c5b),
                            width: 3,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                            width: 3,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xff7a6c5b),
                        )),
                        hintText: 'player 2 name',
                        hintStyle: TextStyle(
                          color: Color(0xff7a6c5b),
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'please enter player 2 name';
                      }
                      return null;
                    },
                  ),
                ).animate().fade(delay: .8.seconds, duration: .9.seconds),
              const  SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: GamePage(
                                  player1: player1Controller.text,
                                  player2: player2Controller.text),
                              type: PageTransitionType.fade));
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:const Color(0xff7a6c5b),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding:const EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                    child:const Text(
                      'Start Game',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xfff3dbcc),
                      ),
                    ).animate().fade(delay: 1.1.seconds, duration: 1.3.seconds),
                  ),
                ).animate().fadeIn(delay: 1.seconds, duration: 1.1.seconds)
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xff7a6c5b),
            ),
          ).animate().fade(delay: .2.seconds, duration: .3.seconds),
        ],
      ),
    );
  }
}
