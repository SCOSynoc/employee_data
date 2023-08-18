import 'package:employess_data/cubit/current_employee_cubit.dart';
import 'package:employess_data/widgets/common_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/colors.dart';
import '../widgets/common_list_body.dart';
import 'add_employees_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appPrimaryColor,
        title: const TextWidget(fontSize: 18, wtg: FontWeight.w500, color: Colors.white, text: 'Employees List',),
      ),
      body: const SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: CommonBody()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appPrimaryColor,

        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddEmployeesForm()));
        },
        child: const Icon(Icons.add, color: Colors.white,),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}