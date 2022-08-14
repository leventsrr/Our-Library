import 'package:flutter/material.dart';
import 'package:our_library/const/const_values.dart';
import 'package:our_library/views/sign_in_page.dart';
import 'package:our_library/widgets/text_form_field.dart';
import 'package:provider/provider.dart';

import '../Firebase/auth.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _passwordProvidingController =
        TextEditingController();
    return Scaffold(
      backgroundColor: Colors.brown[200],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
              child: Column(
            children: [
              CustomTextFormField(
                  keyboardType: TextInputType.text,
                  icon: Icon(Icons.email_outlined),
                  hintText: 'Email Adresin',
                  controller: _emailController,
                  obsecureText: false),
              CustomTextFormField(
                  keyboardType: TextInputType.text,
                  icon: Icon(Icons.security),
                  hintText: 'Şifre',
                  controller: _passwordController,
                  obsecureText: true),
              CustomTextFormField(
                  keyboardType: TextInputType.text,
                  icon: Icon(Icons.security),
                  hintText: 'Şifre Tekrarı',
                  controller: _passwordProvidingController,
                  obsecureText: true),
              ElevatedButton(
                  onPressed: () async {
                    if (_passwordController.text ==
                        _passwordProvidingController.text) {
                      var credential = await Provider.of<Auth>(context,
                              listen: false)
                          .signUp(
                              _emailController.text, _passwordController.text);
                      if (!credential.user!.emailVerified) {
                        credential.user!.sendEmailVerification();
                        var snackBar = SnackBar(
                          duration: Duration(seconds: 5),
                          content: Text(ConstValues().activationCodeMessage),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => const SignInPage()));
                    } else {
                      var snackBar = SnackBar(
                        content: Text(ConstValues().samePasswordWarning),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text(
                    'SignUp',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          )),
          TextButton(
              onPressed: (() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => const SignInPage()));
              }),
              child: Text('Zaten Bir Hesabım Var'))
        ],
      ),
    );
  }
}
