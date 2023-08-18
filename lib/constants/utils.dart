import 'dart:collection';

import 'package:employess_data/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

import '../main.dart';
import '../widgets/common_text_widget.dart';


const String assetPath = "assets/images";
ValueNotifier roleNotifier = ValueNotifier("");
ValueNotifier dateNotifier = ValueNotifier("");
ValueNotifier noDateNotifier = ValueNotifier("");
ValueNotifier noEmployeeData = ValueNotifier({"current": false, "previous": false, "noData": false});

List<String> rolesList = ["Product Designer", "Flutter Developer", "QA Tester", "Product Owner"];
List<Map<String, dynamic>> today_recom = [{"name":"Today", "selected": false},
  {"name":"Next Monday", "selected": false}, {"name":"Next Tuesday", "selected": false},
  {"name":"After 1 week", "selected": false}];

List<String> todays = ["Today","Next Monday","Next Monday","After 1 week",];
List<Map<String, dynamic>> noDate_Recom = [ {"name":"No date","selected": false},{"name":"Today","selected": false},];
const EMPLOYEE_TABLE = "employeeTable";




String getDropText(String from){
  switch(from) {
    case "role": return "Select role";
    case "Today": return "Today";
    case "No date": return "No date";
    default: return "";
  }
}

void navigateToScreen(BuildContext context, Widget screen, {bool replace = false}) {
  if (replace) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => screen));
  } else {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }
}

void navigateAndRemovePush(BuildContext context, Widget screen,){
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => screen),
          (Route<dynamic> route) => false
  );
}

DateTime nextTuesday(DateTime date) {
   return DateTime(date.year, date.month, date.day + date.weekday % 1);
}


DateTime nextMonday(DateTime date) =>
    DateTime(date.year, date.month, date.day - date.weekday % 1);


DateTime getSelectedTime(String chip, DateTime date){
  switch(chip){
    case "Next Tuesday" : DateTime newdate = DateTime.now();
          for(int i = 0; i < 7 ; i++){
          print("here its working $i");
           newdate =date.add(Duration(days: i));
          if(newdate.weekday == 2){
            print("yeah its tuesday ${newdate}");
            break;
          }
        }
      return newdate;
    case "Next Monday": DateTime newdate = DateTime.now();
        for(int i = 0; i < 7 ; i++){
          print("here its working $i");
          newdate =date.add(Duration(days: i));
          if(newdate.weekday == 1){
            print("yeah its tuesday ${newdate}");
            break;
          }
        }
      return newdate;
    case "After 1 week":
            DateTime newdate = DateTime.now();
            newdate =date.add(const Duration(days: 7));
            return newdate;
    case "Today": DateTime newdate = DateTime.now();
         return newdate;
    default : return date;
  }
}


void showSnackBar({required BuildContext context, required String content , required Function() onPressed}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: TextWidget(fontSize: 15, wtg: FontWeight.w400, color: Colors.white, text: content,),
      action: SnackBarAction(label: 'Undo', onPressed: onPressed, textColor: appPrimaryColor,),
    ),
  );

}

void retSnackBar({required BuildContext context, required String content }){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: TextWidget(fontSize: 15, wtg: FontWeight.w400, color: Colors.white, text: content),
    ),
  );
}






