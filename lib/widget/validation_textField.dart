import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ValidationText extends StatelessWidget {
  final controller;
  final hint_text;
  final obscureText;
  final prefix_icon;
  final suffix_icon;
  final hintColor;
  final labelColor;
  final keyboardType;
  final String? Function(String?)? validation;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onTap;
  const ValidationText(
      {Key? key,
      required this.controller,
      required this.hint_text,
        this.prefix_icon,
        this.suffix_icon,
        this.keyboardType,
      this.validation,
      this.obscureText = false,
        this.hintColor = Colors.black,
        this.labelColor=Colors.black,
        this.onTap,
        this.onChanged,
        this.onFieldSubmitted,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
        controller: controller,
        cursorColor: Colors.white,
        onTap: onTap,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: suffix_icon,
          suffixIconColor: Colors.white,
          prefixIcon: prefix_icon,
          hintText: hint_text,
          hintStyle: GoogleFonts.montserrat(color: hintColor,fontSize: 12),
          labelStyle: GoogleFonts.montserrat(color: labelColor),
          fillColor: Colors.black.withOpacity(0.2),
          focusColor: Colors.white,
          hoverColor: Colors.white,
          prefixIconColor: hintColor,
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.zero),
        ),
        validator: validation);
  }
}
