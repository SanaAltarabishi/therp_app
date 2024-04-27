import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_task_app/core/get_it.dart';
import 'package:multi_task_app/pages/religion/duas/duas_provider.dart';
import 'package:multi_task_app/pages/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DuasProvider>(
      create: (context) => DuasProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ExtraPage(),
      ),
    );
  }
}

//! need to fix the mediaQuery of the buttom Nav

class ExtraPage extends StatelessWidget {
  const ExtraPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: () {
          Navigator.push(context,MaterialPageRoute(builder:(context) => SplashScreen(),));
        },
        child: Text(
          ' P',
          style: GoogleFonts.bagelFatOne(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            color: const Color(0xff5c666c),
          ),
        ),
      ),
    );
  }
}
