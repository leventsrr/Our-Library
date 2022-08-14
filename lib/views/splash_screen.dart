import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_library/views/sign_in_page.dart';
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
      'Kitaplarım Bölümünde Kitaba Basılı Tutarak Silebilirsiniz',
      'Argo Kullanan Kullanıcıların Hesapları Uyarılmadan Silinecektir',
      'Burda Sizin Değil Kitapların İsimleri Önemlidir',
      'Artık Sanal Bir Kitaplığın Var.Diğerlerini Bağışlama Vakti...',
      'Çok Yakında Daha Fazla Özellikler Eklenecektir.',
      'TDiğer Kullanıcının Kitabına Eklediğiniz Yorum Sayfaya Yeniden Girdiğinizde Gözükecektir.Bilerek Yapmadık. Düzelteceğiz :D'
    ];

    Random random = new Random();
    int randomNumber = random.nextInt(clues.length);
    return Scaffold(
      backgroundColor: Colors.brown,
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
