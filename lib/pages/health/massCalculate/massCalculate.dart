import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MassCalculatePage extends StatefulWidget {
  const MassCalculatePage({super.key});
  @override
  _MassCalculatePageState createState() => _MassCalculatePageState();
}

class _MassCalculatePageState extends State<MassCalculatePage> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  String bmiResult = '';
  String tipe = '';
  bool isCalculate = false;
  final _massKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff3dbcc),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 40,
              ),
              child: Form(
                key: _massKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                            width: 250,
                            height: 250,
                            child: Image.asset(
                              'images/healthImages/weight-scale.png',
                              fit: BoxFit.cover,
                            ))
                        .animate().shake(delay: .2.seconds, duration: .9.seconds),
                        //.fade(delay: .2.seconds, duration: .3.seconds),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your height';
                        } else {
                          return null;
                        }
                      },
                      cursorColor: const Color(0xffa36168),
                      controller: heightController,
                      decoration: InputDecoration(
                        hintText: 'height(cm)',
                        prefixIcon: const Icon(Icons.sports_gymnastics_rounded),
                        prefixIconColor: const Color(0xffa36168),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Color(0xffa36168),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            width: 3,
                            color: Color(0xffa36168),
                          ),
                        ),
                      ),
                    ).animate().fade(delay: .4.seconds, duration: .5.seconds),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your weight';
                        } else {
                          return null;
                        }
                      },
                      cursorColor: const Color(0xffa36168),
                      controller: weightController,
                      decoration: InputDecoration(
                        hintText: 'Weight(kg)',
                        prefixIcon: const Icon(Icons.fitness_center_outlined),
                        prefixIconColor: const Color(0xffa36168),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            width: 1,
                            color: Color(0xffa36168),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            width: 3,
                            color: Color(0xffa36168),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                    ).animate().fade(delay: .6.seconds, duration: .7.seconds),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffa36168),
                        shadowColor: const Color(0xffa36168),
                        foregroundColor: const Color.fromARGB(255, 136, 24, 12),
                      ),
                      onPressed: () {
                        if (_massKey.currentState!.validate()) {
                          calculateBMI();
                          isCalculate = true;
                        }
                      
                      },
                      child: const Text(
                        'Calculate BMI',
                        style: TextStyle(
                            color: Color(0xfff3dbcc),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ).animate().fade(delay: .8.seconds, duration: .9.seconds),
                    SizedBox(height: 20),
                    isCalculate
                        ? Text(
                            'BMI Result: $bmiResult',
                            style: const TextStyle(
                                color: Color(0xffa36168),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        : Text(''),
                    isCalculate
                        ? Text(
                            'weight Category: $tipe',
                            style: const TextStyle(
                                color: Color(0xffa36168),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )
                        : Text(''),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xffa36168),
            ),
          ).animate().fade(delay: .2.seconds, duration: .3.seconds),
        ],
      ),
    );
  }

  void calculateBMI() {
    if (_massKey.currentState!.validate()) {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) /
          100; // Convert height from cm to meters

      double bmi = weight / (height * height);
      String bodyTipe = '';
      if (bmi < 18.5) {
        bodyTipe = 'underweight';
      } else if (bmi > 18.5 && bmi < 24.9) {
        bodyTipe = 'normal';
      } else if (bmi > 24.9 && bmi < 29.9) {
        bodyTipe = 'overweight';
      } else {
        bodyTipe = 'obesity';
      }
      setState(() {
        bmiResult = bmi
            .toStringAsFixed(2); // Display BMI result with two decimal places
        tipe = bodyTipe;
      });
    }
  }
}
