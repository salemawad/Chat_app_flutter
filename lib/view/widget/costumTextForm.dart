import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  final String title, hint;
  final IconData? icon;
  // final TextEditingController mycontroller;
  // final bool obscuertext;

    const CustomField(
      {Key? key,
        required this.title,
        // required this.mycontroller,
        // required this.obscuertext,
        this.icon, required this.hint
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextField(
      // obscureText: obscuertext,
      decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon),
          label: Text(title),
          border: const OutlineInputBorder(
              borderSide: BorderSide(width: 1),
              borderRadius: BorderRadius.all(Radius.circular(5)))),
    );
  }
}
