import 'package:flutter/material.dart';

import '../consts/colors.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData iconData ;
  final FormFieldValidator validate;
  const CustomTextField(
      {required this.controller,
      required this.hintText,
      this.keyboardType = TextInputType.text,
      required this.validate,
        required this.iconData ,
         this.obscureText = false ,
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscuringCharacter: '*',
      obscureText: obscureText,
      validator: validate,
      style: const TextStyle(color: secondaryTextColor, fontWeight: FontWeight.bold,fontSize: 14),
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        label: Icon(iconData,color: secondaryTextColor,),
        hintStyle: const TextStyle(color: secondaryTextColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: secondaryTextFieldColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: blueColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: redColor, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: secondaryTextFieldColor, width: 1),
        ),
      ),
    );
  }
}
