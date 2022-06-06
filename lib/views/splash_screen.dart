import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_library/views/sign_in_page.dart';
import 'dart:math';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (builder) => SignInPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> clues = [
      'You Can Delete Books by Long Touching in My Books Section',
      'Users Using Slang Will Be Banned Without Warning',
      'Here We Look at Books, Not Names and Gender',
      'Now You Have A Virtual Library. Donate Your Books to Those in Need',
      'Coming Soon With More Language Support and Advanced Features...',
      'To update the book comments, you must log in to the book page again from the main page. We will fix it as soon as possible :)'
    ];

    Random random = new Random();
    int randomNumber = random.nextInt(clues.length);
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "OUR LIBRARY",
            textAlign: TextAlign.center,
            style: GoogleFonts.courgette(
              textStyle: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              clues[randomNumber],
              textAlign: TextAlign.center,
              style: GoogleFonts.courgette(
                textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
