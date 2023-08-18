
import 'package:hive/hive.dart';
part 'employee_model.g.dart';


@HiveType(typeId: 0)
class Employee {

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String role;

  @HiveField(3)
  final String fromDate;

  @HiveField(4)
  final String toDate;

  Employee({required this.id, required this.name, required this.role, required this.fromDate, required this.toDate,});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(id: json["id"], name: json["name"], role: json["role"], fromDate: json["fromDate"], toDate:json["toDate"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id, "name": name, "role":role, "fromDate": fromDate, "toDate": toDate
    };
  }



}

class EmployeesList {
  final List<Employee> employees;

  EmployeesList({required this.employees});

  Map<String, dynamic> toJson() {
    return {
      "employeesList": employees,
    };
  }

  factory EmployeesList.fromJson(Map<String,dynamic> json) {
    return EmployeesList(employees: List<Employee>.from(json["employeesList"].map((x) => Employee.fromJson(x))));
  }
}
