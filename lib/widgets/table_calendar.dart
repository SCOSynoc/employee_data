
import 'dart:collection';
import 'dart:ui';
import 'package:employess_data/constants/colors.dart';
import 'package:employess_data/constants/utils.dart';
import 'package:employess_data/widgets/category_chips.dart';
import 'package:employess_data/widgets/common_button.dart';
import 'package:employess_data/widgets/common_text_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class TableCalendarCard extends StatefulWidget {
  const TableCalendarCard({Key? key, required this.list, required this.from}) : super(key: key);
  final List<Map<String, dynamic>> list;
  final String from;

  @override
  State<TableCalendarCard> createState() => _TableCalendarCardState();
}

class _TableCalendarCardState extends State<TableCalendarCard> {
  DateTime today = DateTime.now();
  bool chipSelected = false;
  DateTime focusedChipDate = DateTime.now();
  String chip = "";


  void _onDaySelected(DateTime day, DateTime focusedDay){
    setState(() {
      today = day;
      chipSelected = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
      children: [
          Flexible(
            fit: FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
              child: GridView.count(
                shrinkWrap: true,
                childAspectRatio: 4,
                crossAxisCount: 2, children: List.generate(widget.list.length, (index) => Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                        setState(() {
                          chipSelected = true;
                          widget.list[index]["selected"] = true;
                          for(int i =0 ; i < widget.list.length ; i++){
                              if( i != index) {
                                widget.list[i]["selected"] = false;
                              }
                          }
                         focusedChipDate = getSelectedTime(widget.list[index]["name"], today);
                          chip = widget.list[index]["name"];
                        });
                    },
                    child: Container(
                     width: 171,
                     height: 55,
                     decoration: BoxDecoration(
                         color:widget.list[index]["selected"] ? appPrimaryColor : appSecondaryColor,
                         borderRadius: BorderRadius.circular(4.0),
                     ),
                    child:  Center(
                      child: TextWidget(
                      fontSize: 14,
                      wtg: FontWeight.w400,
                      color: widget.list[index]["selected"]? Colors.white :appPrimaryColor,
                      text: widget.list[index]["name"],
              ),
                    ),),
                  ) ,
                )
              ),
              ),
            ),
          ),
          TableCalendar(
            rowHeight: 38,
              headerStyle: HeaderStyle(
                titleTextStyle: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500),
                  titleCentered: true, formatButtonVisible: false,
                  leftChevronMargin: EdgeInsets.zero,
                rightChevronMargin: EdgeInsets.zero,
              leftChevronPadding :EdgeInsets.only(top: 12.0, bottom: 12.0, left: 70,),
                  rightChevronPadding : EdgeInsets.only(top: 12.0, bottom: 12.0, right: 70,),
                leftChevronIcon: SvgPicture.asset("$assetPath/left_calendar.svg"),
                rightChevronIcon: SvgPicture.asset("$assetPath/right_calendar.svg"),
              ),
               selectedDayPredicate: (day) => isSameDay(day,chipSelected ?focusedChipDate: today),
              focusedDay: chipSelected? focusedChipDate: DateTime.now(),
              firstDay: DateTime(1900),
              lastDay: DateTime(2300),
              calendarStyle: CalendarStyle(
                todayDecoration: const BoxDecoration(border: Border(
                    top: BorderSide(color: appPrimaryColor),
                  bottom:BorderSide(color: appPrimaryColor), left: BorderSide(color: appPrimaryColor),
                  right:BorderSide(color: appPrimaryColor),  ), shape: BoxShape.circle),
                todayTextStyle: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: appPrimaryColor),
                selectedDecoration:BoxDecoration(color: appPrimaryColor, shape: BoxShape.circle),
                defaultTextStyle:GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w400, color: appFontPrimaryColor)
              ),
              onDaySelected: _onDaySelected,

          ),
        SizedBox(height: 40,),
        Divider(
          color: Colors.grey[200],
          thickness: 1.5,
        ),
        TableFooter( dateText: chip == "No date"?"No date":chipSelected  ? DateFormat("dd MMM yyyy").format(focusedChipDate):
                              DateFormat("dd MMM yyyy").format(today) , from: widget.from, list: widget.list,)
      ],
    ),);
  }
}

class TableFooter extends StatelessWidget {
  const TableFooter({
    super.key, required this.dateText, required this.from, required this.list,
  });
  final String dateText;
  final String from;
  final List<Map<String,dynamic>> list;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Flexible(
        fit: FlexFit.loose,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Row(
              children: [
                SvgPicture.asset('$assetPath/calendar.svg'),
                SizedBox(width: 10,),
                TextWidget(fontSize: 16, wtg: FontWeight.w400, color: appFontPrimaryColor, text: "$dateText")
              ],
            ),
          ),
        ),
      ),
      Flexible(
        fit: FlexFit.loose,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Row(
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: CommonElevatedButton(text: "Cancel", color: appPrimaryColor, buttonColor: appSecondaryColor, onPressed: () {
                  for(int i =0 ; i < list.length ; i++){
                    list[i]["selected"] = false;
                  }
                  Navigator.pop(context);
                },),
              ),
              const SizedBox(width: 14,),
              Flexible(
                fit: FlexFit.loose,
                child: CommonElevatedButton(text: "Save", color: Colors.white, buttonColor: appPrimaryColor, onPressed: (){
                  if(from == "today"){
                    dateNotifier.value = dateText;
                  }else{
                    noDateNotifier.value = dateText == "No date"? "": dateText;
                  }
                  for(int i =0 ; i < list.length ; i++){
                      list[i]["selected"] = false;
                  }
                    Navigator.pop(context);
                },),
              )
          ],) ,),
        ),
      )
    ],);
  }
}



