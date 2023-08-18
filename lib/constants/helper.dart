import 'dart:convert';

import 'package:employess_data/constants/utils.dart';
import 'package:hive/hive.dart';

import '../model/employee_model.dart';

class Helper {
  static List<Employee> getPreviousEmployees() {
    var db = Hive.box(EMPLOYEE_TABLE);
    print("${db.values}");
    var datas = db.get("employeeList") ?? jsonEncode({"employeesList": []});
    EmployeesList data =  EmployeesList.fromJson(jsonDecode(datas));
    List<Employee> emp = data.employees;
    List<Employee> prevEmp = [];
    for( Employee e in emp) {
      if(e.toDate.isNotEmpty){
        prevEmp.add(e);
      }
    }
    noEmployeeData.value["previous"] = prevEmp.isEmpty;
    return prevEmp;
  }


  static List<Employee> getCurrentEmployees() {
    var db = Hive.box(EMPLOYEE_TABLE);
    print("${db.values} and ${db.get("employeeList")}");
    var datas = db.get("employeeList") ?? jsonEncode({"employeesList": []});
    EmployeesList data =  EmployeesList.fromJson(jsonDecode(datas));
    print("here data is $data");
    List<Employee> emp = data.employees;
    List<Employee> currEmp = [];
    for( Employee e in emp) {
      if(e.toDate.isEmpty){
        currEmp.add(e);
      }
    }
    noEmployeeData.value["current"] = currEmp.isEmpty;
    return currEmp;
  }




}