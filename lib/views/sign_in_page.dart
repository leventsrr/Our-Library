import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_library/views/forgot_password_page.dart';
import 'package:my_library/views/home_page.dart';
import 'package:my_library/views/sign_up_page.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'asset/images/books.png',
            ),
          ),
          Form(
              child: Column(
            children: [
              CustomTextFormField(
                  keyboardType: TextInputType.text,
                  icon: Icon(Icons.email_outlined),
                  hintText: 'Your E-mail',
                  controller: _emailController,
                  obsecureText: false),
              CustomTextFormField(
                  keyboardType: TextInputType.text,
                  icon: Icon(Icons.security),
                  hintText: 'Your Password',
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
                        //Provider.of<Auth>(context, listen: false).signOut();
                        const snackBar = SnackBar(
                          content: Text('Your Email Is Not Verified'),
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
                          content: Text('User Not Found'),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (e.code == 'wrong-password') {
                        const snackBar = SnackBar(
                          content: Text('Wrong Password'),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  child: Text(
                    'SignIn',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          )),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => SignUpPage()));
              },
              child: Text("Don't You Have An Account?")),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => ForgotPassword()));
              },
              child: Text("Forgot Password"))
        ],
      ),
    );
  }
}
