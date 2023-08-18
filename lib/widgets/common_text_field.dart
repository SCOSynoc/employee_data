import 'package:employess_data/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({Key? key, required this.obscureText, required this.label, required this.controller, required this.prefixIcon,  this.suffixIcon, this.readOnly,}) : super(key: key);
  final bool obscureText;
  final String label;
  final TextEditingController controller;
  final Widget prefixIcon;
  final Widget? suffixIcon;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      readOnly: readOnly ?? false,
      controller: controller,
      obscureText: obscureText,
      prefix: Padding(
        padding: const EdgeInsets.all(8.0),
        child: prefixIcon,
      ),
      placeholder: label,
      style: GoogleFonts.roboto(color: appFontPrimaryColor, fontSize: 16, fontWeight: FontWeight.w400),
      suffix: Padding(
        padding: const EdgeInsets.all(8.0),
        child: suffixIcon,
      ),

    );;
  }
}
