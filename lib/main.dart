import 'package:admin/screens/auth/splash_screen.dart';
import 'package:flutter/material.dart';

main() {
  runApp(QuizAppAdmin());
}

class QuizAppAdmin extends StatefulWidget {
  const QuizAppAdmin({Key? key}) : super(key: key);

  @override
  State<QuizAppAdmin> createState() => _QuizAppAdminState();
}

class _QuizAppAdminState extends State<QuizAppAdmin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Kursun Adi',
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}
