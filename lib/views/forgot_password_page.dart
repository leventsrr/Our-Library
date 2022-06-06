import 'package:flutter/material.dart';
import 'package:my_library/Firebase/auth.dart';
import 'package:my_library/views/sign_in_page.dart';
import 'package:my_library/widgets/text_form_field.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatelessWidget {
  TextEditingController _mailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextFormField(
              hintText: 'Your E-mail',
              controller: _mailController,
              obsecureText: false,
              icon: Icon(Icons.mail),
              keyboardType: TextInputType.emailAddress),
          ElevatedButton(
              onPressed: () {
                Provider.of<Auth>(context, listen: false)
                    .resetPassword(_mailController.text);
              },
              child: Text("Send Me Reset Mail")),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => SignInPage()));
              },
              child: Text('Sign In Page'))
        ],
      )),
    );
  }
}
