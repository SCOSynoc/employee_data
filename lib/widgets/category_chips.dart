/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../constants/utils.dart';
import 'common_text_widget.dart';


class CategoryChips extends StatefulWidget {
  const CategoryChips({Key? key, required this.data, required this.index}) : super(key: key);
  final String data;
  final int index;
  @override
  State<CategoryChips> createState() => _CategoryChipsState();
}

class _CategoryChipsState extends State<CategoryChips> {
  String selectedCategory = "";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FilterChip(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),),
        selectedColor: appPrimaryColor,
        backgroundColor: appSecondaryColor,
        label: TextWidget(
          fontSize: 14,
          wtg: FontWeight.w400,
          color: selectedCategory == todays[widget.index]? Colors.white :appPrimaryColor,
          text: widget.data,
        ),
        onSelected:(bool value){
          if(value){
            setState(() {
              selectedCategory = widget.data;
            });
            */
/*sortValueNotifierInHomeScreen.value = selectedCategory;*//*

          }else{
            selectedCategory = "";
          }
        },
        selected: selectedCategory == todays[widget.index], // Set to true if you want some chips to be initially selected
      ),
    );;
  }
}

*/
