import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_library/Firebase/storage.dart';
import 'package:my_library/widgets/text_form_field.dart';
import 'package:provider/provider.dart';

import '../Firebase/auth.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({Key? key}) : super(key: key);

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _bookNameController = TextEditingController();
    final TextEditingController _authorNameController = TextEditingController();
    final TextEditingController _publisherController = TextEditingController();
    final TextEditingController _aboutBookController = TextEditingController();
    final TextEditingController _rateController = TextEditingController();

    bool controlTextFormFields(
        String rateController,
        String bookNameController,
        String authorNameController,
        String publisherController,
        String aboutBookController) {
      if (rateController == "" ||
          bookNameController == "" ||
          authorNameController == "" ||
          publisherController == "" ||
          aboutBookController == "") {
        return false;
      }
      var rate = int.tryParse(rateController);
      if (rate == null) {
        return false;
      }
      if (int.parse(rateController) > 5 || int.parse(rateController) < 1) {
        return false;
      }
      return true;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
                child: Column(
              children: [
                CustomTextFormField(
                    keyboardType: TextInputType.text,
                    hintText: 'Book Name',
                    controller: _bookNameController,
                    obsecureText: false,
                    icon: const Icon(Icons.book_outlined)),
                CustomTextFormField(
                    keyboardType: TextInputType.text,
                    hintText: 'Author Name',
                    controller: _authorNameController,
                    obsecureText: false,
                    icon: const Icon(Icons.account_circle_outlined)),
                CustomTextFormField(
                    keyboardType: TextInputType.text,
                    hintText: 'Publisher',
                    controller: _publisherController,
                    obsecureText: false,
                    icon: const Icon(Icons.account_balance_outlined)),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    controller: _aboutBookController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.comment),
                        border: OutlineInputBorder(),
                        hintText: 'About Book'),
                  ),
                ),
                CustomTextFormField(
                    keyboardType: TextInputType.number,
                    hintText: 'Rate (1-5)',
                    controller: _rateController,
                    obsecureText: false,
                    icon: const Icon(Icons.star_border)),
              ],
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var userUid =
              Provider.of<Auth>(context, listen: false).reachToUserUid();
          bool isCorrect = controlTextFormFields(
              _rateController.text,
              _bookNameController.text,
              _authorNameController.text,
              _publisherController.text,
              _aboutBookController.text);
          if (isCorrect) {
            await Provider.of<Storage>(context, listen: false).addBook(
                _bookNameController.text,
                _authorNameController.text,
                _publisherController.text,
                _aboutBookController.text,
                _rateController.text,
                userUid,
                [],
                Timestamp.now());
            setState(() {
              _publisherController.text = "";
              _aboutBookController.text = "";
              _authorNameController.text = "";
              _rateController.text = "";
              _bookNameController.text = "";
            });
          } else {
            const snackBar = SnackBar(
              content: Text('Make sure you fill in the information properly'),
            );

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: Icon(
          Icons.bookmark_add_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
