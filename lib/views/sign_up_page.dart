import 'package:flutter/material.dart';
import 'package:my_library/views/sign_in_page.dart';
import 'package:my_library/widgets/text_form_field.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'asset/images/bookss.png',
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
              CustomTextFormField(
                  keyboardType: TextInputType.text,
                  icon: Icon(Icons.security),
                  hintText: 'Your Password Again',
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
                        const snackBar = SnackBar(
                          duration: Duration(seconds: 5),
                          content: Text(
                              'We Sent You Activation Code.Please Check Your Email.'),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => const SignInPage()));
                    } else {
                      const snackBar = SnackBar(
                        content: Text('Your Passwords Are Not Same'),
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
              child: Text('Do You Have An Account ?'))
        ],
      ),
    );
  }
}
