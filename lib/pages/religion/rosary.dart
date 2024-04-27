import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RosaryCounterPage extends StatefulWidget {
  const RosaryCounterPage({super.key});

  @override
  State<RosaryCounterPage> createState() => _RosaryCounterPageState();
}

class _RosaryCounterPageState extends State<RosaryCounterPage> {
  List<String> prayers = [
    'استغفر الله',
    'سبحان الله',
    'الحمد لله',
    'لا اله الا الله',
   // 'لا حول ولا قوة الا بالله ',
  ];
  int currentPrayerIndex = 0;
  int prayerCount = 0;
  void navigateLeft() {
    setState(() {
      currentPrayerIndex = (currentPrayerIndex - 1) % prayers.length;
      if (currentPrayerIndex < 0) {
        currentPrayerIndex += prayers.length;
      }
      prayerCount = 0;
    });
  }

  void navigateRight() {
    setState(() {
      currentPrayerIndex = (currentPrayerIndex + 1) % prayers.length;
      prayerCount = 0;
    });
  }

  void incrementCount() {
    setState(() {
      prayerCount++;
    });
  }

  void resetCount() {
    setState(() {
      prayerCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xfff3dbcc),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Color(0xffa96054),
                        ),
                        onPressed: navigateLeft,
                      ),
                      SizedBox(
                        // alignment: Alignment.center,
                        width: screenWidth*0.8,//500,
                       height: screenHeight*0.5,//500,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                'images/religionImages/label (1).png',
                                //'images/religionImages/frame-design (1).png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                prayers[currentPrayerIndex],
                                style:  TextStyle(
                                    color: Color(0xffa96054),
                                    fontWeight: FontWeight.bold,
                                    fontSize:screenWidth*0.04),
                              ).animate().fade(
                                  delay: .6.seconds, duration: .5.seconds),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: navigateRight,
                          icon: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Color(0xffa96054),
                          ))
                    ],
                  ).animate().fade(delay: .4.seconds, duration: .5.seconds),
                ),
                Text(
                  'Count:$prayerCount',
                  style: const TextStyle(
                      color: Color(0xffa96054),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ).animate().fade(delay: .6.seconds, duration: .7.seconds),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // textStyle: TextStyle(color:Color(0xfff3dbcc),fontSize: 20,fontWeight: FontWeight.bold),
                    backgroundColor: const Color(0xffa96054),
                    shadowColor: const Color(0xffa96054),
                    foregroundColor: const Color.fromARGB(255, 136, 24, 12),
                  ),
                  onPressed: incrementCount,
                  child: const Text(
                    '    Increament    ',
                    style: TextStyle(
                      color: Color(0xfff3dbcc),
                    ),
                  ),
                ).animate().fade(delay: .8.seconds, duration: .9.seconds),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // textStyle: TextStyle(color:Color(0xfff3dbcc),fontSize: 20,fontWeight: FontWeight.bold),
                      backgroundColor: const Color(0xffa96054),
                      shadowColor: const Color(0xffa96054),
                      foregroundColor: const Color.fromARGB(255, 136, 24, 12),
                    ),
                    onPressed: resetCount,
                    child: const Text(
                      'reset',
                      style: TextStyle(color: Color(0xfff3dbcc)),
                    )).animate().fade(delay: 1.seconds, duration: 1.1.seconds),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xffa96054),
            ),
          ).animate().fade(delay: .2.seconds, duration: .3.seconds),
        ],
      ),
    );
  }
}
