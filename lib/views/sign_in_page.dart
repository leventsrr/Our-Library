import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:our_library/views/forgot_password_page.dart';
import 'package:our_library/views/home_page.dart';
import 'package:our_library/views/sign_up_page.dart';
import 'package:provider/provider.dart';

import '../Firebase/auth.dart';
import '../widgets/text_form_field.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.brown[200],
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "OUR LIBRARY",
            style: TextStyle(
                fontSize: 50,
                color: Colors.brown[900],
                fontWeight: FontWeight.bold),
          ),
          Form(
              child: Column(
            children: [
              CustomTextFormField(
                  keyboardType: TextInputType.text,
                  icon: Icon(Icons.email_outlined),
                  hintText: 'Email',
                  controller: _emailController,
                  obsecureText: false),
              CustomTextFormField(
                  keyboardType: TextInputType.text,
                  icon: Icon(Icons.security),
                  hintText: 'Şifre',
                  controller: _passwordController,
                  obsecureText: true),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      final credential = await Provider.of<Auth>(context,
                              listen: false)
                          .signInWithEmailAndPassword(
                              _emailController.text, _passwordController.text);
                      Provider.of<Auth>(context, listen: false)
                          .changeUserInformation(credential);
                      if (!credential.user!.emailVerified) {
                        const snackBar = SnackBar(
                          content: Text('Girilen Email Doğrulanmamış'),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (credential.user!.emailVerified) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => HomePage()));
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == "user-not-found") {
                        const snackBar = SnackBar(
                          content: Text('Kullanıcı Bulunamadı'),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (e.code == 'wrong-password') {
                        const snackBar = SnackBar(
                          content: Text('Yanlış Şifre'),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  child: Text(
                    'Giriş Yap',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          )),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => SignUpPage()));
              },
              child: Text(
                "Henüz Hesabın Yok Mu?",
                style: TextStyle(color: Colors.white),
              )),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => ForgotPassword()));
              },
              child: Text(
                "Şifremi Unuttum",
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
