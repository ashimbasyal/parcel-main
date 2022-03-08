import 'package:flutter/material.dart';


class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  bool isObsecre = true;
  bool enabled = true;

 
  CustomTextfield(
      {this.controller,
      this.data,
      this.hintText,
      this.isObsecre,
      this.enabled});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration (
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(10),
      child: TextField(
        enabled: enabled,
        controller: controller,
        obscureText: isObsecre,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefix: Icon(
            data,
            color: Colors.black,
          ),
          focusColor: Theme.of(context).primaryColor,
          hintText: hintText,
        ),
      ),
    );
  }
}
