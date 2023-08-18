import 'dart:convert';

import 'package:employess_data/constants/helper.dart';
import 'package:employess_data/constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import '../model/employee_model.dart';


// State
class EmployeeState extends Equatable {
  final List<Employee> employees;

  EmployeeState(this.employees);

  @override
  List<Object?> get props => [employees];
}

class InitialState extends EmployeeState {
  InitialState(super.employees);

}

// Events
abstract class EmployeeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddEmployee extends EmployeeEvent {
  final Employee employee;

  AddEmployee(this.employee);

  @override
  List<Object?> get props => [employee];
}

// Cubit
class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit() : super(EmployeeState([]));

 /* void addEmployee(Employee employee) {
    List<Employee> updatedEmployees = List.from(state.employees)..add(employee);
    emit(EmployeeState(updatedEmployees));
  }*/

  void addEmployee(Employee employee) {
    /*state.add(employee);*/
    List<Employee> updatedEmp = List.from(state.employees)..add(employee);
    /*var db = HiveDB.getBox(EMPLOYEE_TABLE);*/
    var db = Hive.box(EMPLOYEE_TABLE);
    var datas = db.get("employeeList") ?? jsonEncode({"employeesList": []});
    EmployeesList data =  EmployeesList.fromJson(jsonDecode(datas));
    print("here data is $data");
    List<Employee> emp = data.employees ?? [];
    if(emp.isEmpty){
      EmployeesList list = EmployeesList(employees: updatedEmp);
      db.put("employeeList",jsonEncode(list.toJson()));
    }else{
      emp.add(employee);
      EmployeesList list = EmployeesList(employees: emp);
      db.put("employeeList",jsonEncode(list.toJson()));
    }

    emit(EmployeeState(updatedEmp));
  }

  void updateEmployees({required Employee updEmployee, required String empId}){
    var db = Hive.box(EMPLOYEE_TABLE);
    var datas = db.get("employeeList") ?? jsonEncode({"employeesList": []});
    EmployeesList data =  EmployeesList.fromJson(jsonDecode(datas));
    print("here data is $data");
    List<Employee> emp = data.employees;
    print("updated data is ${updEmployee.toDate}");
    for(int i = 0 ; i < emp.length ; i++) {
      if(emp[i].id == empId){
        emp[i] = updEmployee;
      }
    }
    EmployeesList list = EmployeesList(employees: emp);
    db.put("employeeList",jsonEncode(list.toJson()));
    emit(EmployeeState(emp));
  }

  void removeData(String id, BuildContext context, Employee deletedData){
    var db = Hive.box(EMPLOYEE_TABLE);
    var datas = db.get("employeeList") ?? jsonEncode({"employeesList": []});
    EmployeesList data =  EmployeesList.fromJson(jsonDecode(datas));
    List<Employee> emp = data.employees;
    List<Employee> updateEmp = [];
    for(Employee e in emp){
      if(e.id == id){
      }else{
        updateEmp.add(e);
      }
    }
    EmployeesList list = EmployeesList(employees: updateEmp);
    db.put("employeeList",jsonEncode(list.toJson()));
    emit(EmployeeState(updateEmp));
    showSnackBar(context: context, content: "Employee data has been deleted", onPressed: () {
       addEmployee(deletedData);
    },);
  }

  void checkEmployeeRecords(){
    var db = Hive.box(EMPLOYEE_TABLE);
    var datas = db.get("employeeList") ?? jsonEncode({"employeesList": []});
    EmployeesList data =  EmployeesList.fromJson(jsonDecode(datas));
    List<Employee> emp = data.employees;
    emit(EmployeeState(emp));
  }



 /* void getPreviousEmployees() {
    var db = Hive.box(EMPLOYEE_TABLE);
    print("${db.values}");
    List<Employee> emp = db.get("employeeList") ?? [];
    List<Employee> prevEmp = [];
    for( Employee e in emp) {
      if(e.toDate.isNotEmpty){
        prevEmp.add(e);
      }
    }
    emit(EmployeeState(prevEmp));
  }

  void getCurrentEmployees() {
    var db = Hive.box(EMPLOYEE_TABLE);
    print("${db.values} and ${db.get("employeeList")}");
    EmployeesList data =  EmployeesList.fromJson(jsonDecode(db.get("employeeList")));
    print("here data is $data");
    List<Employee> emp = data.employees;
    List<Employee> currEmp = [];
    for( Employee e in emp) {
      if(e.toDate.isNotEmpty){
        currEmp.add(e);
      }
    }
    emit(EmployeeState(currEmp));
  }*/

}


