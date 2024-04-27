import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_task_app/pages/home_screen.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return MyDrawer(
      drawer: Scaffold(
        body: Container(
          color:const Color(0xfff3dbcc).withOpacity(0.9),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'T',
                        style: GoogleFonts.bagelFatOne(
                          fontSize: screenWidth / 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffcb8780),
                        ),
                      ),
                      Text(
                        ' H',
                        style: GoogleFonts.bagelFatOne(
                          fontSize: screenWidth / 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffa36168),
                        ),
                      ),
                      Text(
                        ' E',
                        style: GoogleFonts.bagelFatOne(
                            fontSize: screenWidth / 12,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff7a6c5b)
                            // const Color(0xffa5a4a3),
                            ),
                      ),
                      Text(
                        ' R',
                        style: GoogleFonts.bagelFatOne(
                          fontSize: screenWidth / 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffa96054),
                        ),
                      ),
                      Text(
                        ' P',
                        style: GoogleFonts.bagelFatOne(
                          fontSize: screenWidth / 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff5c666c),
                        ),
                      ),
                    ],
                  )
                      .animate(
                        onPlay: (controller) => controller.repeat(),
                      )
                      .shimmer(duration: 2.seconds),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    children: [
                      Text(
                        'T:',
                        style: GoogleFonts.bagelFatOne(
                          fontSize: screenWidth / 30,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffcb8780),
                        ),
                      ),
                      Text(
                        ' represent Tools',
                        style: GoogleFonts.bagelFatOne(
                          fontSize: screenWidth / 30,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff795a59),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'H:',
                        style: GoogleFonts.bagelFatOne(
                          fontSize: screenWidth / 30,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffa36168),
                        ),
                      ),
                      Text(
                        ' represent Health',
                        style: GoogleFonts.bagelFatOne(
                          fontSize: screenWidth / 30,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff795a59),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'E:',
                        style: GoogleFonts.bagelFatOne(
                          fontSize: screenWidth / 30,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff7a6c5b),
                        ),
                      ),
                      Text(
                        ' represent Entertainment',
                        style: GoogleFonts.bagelFatOne(
                          fontSize: screenWidth / 30,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff795a59),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'R:',
                        style: GoogleFonts.bagelFatOne(
                          fontSize: screenWidth / 30,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xffa96054),
                        ),
                      ),
                      Text(
                        ' represent Religion',
                        style: GoogleFonts.bagelFatOne(
                          fontSize: screenWidth / 30,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff795a59),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'P:',
                        style: GoogleFonts.bagelFatOne(
                          fontSize: screenWidth / 30,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff5c666c),
                        ),
                      ),
                      Text(
                        ' represent Productivity',
                        style: GoogleFonts.bagelFatOne(
                          fontSize: screenWidth / 30,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff795a59),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      child:const HomeScreen(),
    );
  }
}

class MyDrawer extends StatefulWidget {
  final Widget child;
  final Widget drawer;
  const MyDrawer({super.key, required this.child, required this.drawer});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {
  late AnimationController _xControllerForChild;
  late Animation<double> _yRotationAnimationForChild;
  late AnimationController _xControllerForDrawer;
  late Animation<double> _yRotationAnimationForDrawer;

  @override
  void initState() {
    super.initState();
    _xControllerForChild =
        AnimationController(vsync: this, duration:const Duration(milliseconds: 500));
    _yRotationAnimationForChild =
        Tween<double>(begin: 0, end: -pi / 2).animate(_xControllerForChild);
    _xControllerForDrawer =
        AnimationController(vsync: this, duration:const Duration(milliseconds: 500));
    _yRotationAnimationForDrawer =
        Tween<double>(begin: -pi / 2.7, end: 0).animate(_xControllerForDrawer);
  }

  @override
  void dispose() {
    _xControllerForChild.dispose();
    _xControllerForDrawer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxDrag = screenWidth * 0.7;
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        _xControllerForChild.value += details.delta.dx / maxDrag;
        _xControllerForDrawer.value += details.delta.dx / maxDrag;
      },
      onHorizontalDragEnd: (details) {
        if (_xControllerForChild.value < 0.5) {
          _xControllerForChild.reverse();
          _xControllerForDrawer.reverse();
        } else {
          _xControllerForChild.forward();
          _xControllerForDrawer.forward();
        }
      },
      child: AnimatedBuilder(
        animation: Listenable.merge(
          [
            _xControllerForChild,
            _xControllerForDrawer,
          ],
        ),
        builder: (context, child) {
          return Stack(
            children: [
              Container(
                decoration:const BoxDecoration(
                    gradient: LinearGradient(
                        stops: [0.2, 0.4, 0.6, 0.8, 1],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xffcb8780),
                          Color(0xffa36168),
                          Color(0xff7a6c5b),
                          Color(0xffa96054),
                          Color(0xff5c666c),
                        ])),
              ),
              Transform(
                alignment: Alignment.centerLeft,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(_xControllerForChild.value * maxDrag)
                  ..rotateY(_yRotationAnimationForChild.value),
                child: widget.child,
              ),
              Transform(
                alignment: Alignment.centerRight,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..translate(
                      -screenWidth + _xControllerForDrawer.value * maxDrag)
                  ..rotateY(_yRotationAnimationForDrawer.value),
                child: widget.drawer,
              ),
            ],
          );
        },
      ),
    );
  }
}
