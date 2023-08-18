import 'package:employess_data/constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/common_text_widget.dart';



abstract class Validate {
    void commonFunction(BuildContext context );
    factory Validate( String name, String role , String fromDate) {
      if(name.isEmpty){
        return NotifyInfoBar("Please enter name");
      }
      if(role.isEmpty){
        return NotifyInfoBar("Please enter role");
      }
      if(fromDate.isEmpty){
        return NotifyInfoBar("Please enter today's date");
      }
      return ValidationSuccess();
    }
}


class NotifyInfoBar implements Validate {
  final String content;

  NotifyInfoBar(this.content);
  @override
  void commonFunction(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: TextWidget(fontSize: 15, wtg: FontWeight.w400, color: Colors.white, text: content,),
      ),
    );
    throw Exception(content);
  }

}

class ValidationSuccess implements Validate {
  @override
  void commonFunction(BuildContext context) {
    // TODO: implement commonFunction
  }
}

class IdleValidated implements Validate {
  @override
  void commonFunction(BuildContext context) {
    // TODO: implement commonFunction
  }

}

