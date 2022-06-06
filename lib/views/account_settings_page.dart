import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_library/views/sign_in_page.dart';
import 'package:my_library/widgets/text_form_field.dart';
import 'package:provider/provider.dart';

import '../Firebase/auth.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _mailController = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Form(
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
                  child: Text("Send Me Reset Password Mail")),
            ],
          )),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title:
                        const Text('Do You Really Want To Delete Your Account'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          UserCredential user =
                              Provider.of<Auth>(context, listen: false)
                                  .reachUser();
                          Provider.of<Auth>(context, listen: false).signOut();
                          Provider.of<Auth>(context, listen: false)
                              .deleteAccount(user.user);

                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => SignInPage()),
                              (Route<dynamic> route) => false);
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Delete My Account'))
        ],
      ),
    );
  }
}
