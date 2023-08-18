import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'common_text_widget.dart';

class CommonElevatedButton extends StatefulWidget {
  const CommonElevatedButton({Key? key, this.onPressed, required this.text, required this.color, required this.buttonColor}) : super(key: key);
  final Function()? onPressed;
  final String text;
  final Color color;
  final Color buttonColor;
  @override
  State<CommonElevatedButton> createState() => _CommonElevatedButtonState();
}

class _CommonElevatedButtonState extends State<CommonElevatedButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(6) ),
        color: widget.buttonColor,
        onPressed: widget.onPressed,
        /*shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),*/
        child:TextWidget(fontSize: 14, wtg: FontWeight.w400, color: widget.color, text: widget.text,),
      ),
    );
  }
}