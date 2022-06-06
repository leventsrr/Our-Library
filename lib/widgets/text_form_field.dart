import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  TextEditingController controller;
  String hintText;
  bool obsecureText;
  Icon icon;
  TextInputType keyboardType;
  CustomTextFormField(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.obsecureText,
      required this.icon,
      required this.keyboardType})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: obsecureText,
        controller: controller,
        decoration: InputDecoration(
            prefixIcon: icon,
            border: const OutlineInputBorder(),
            labelText: hintText),
      ),
    );
  }
}
