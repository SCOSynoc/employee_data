import 'package:employess_data/constants/colors.dart';
import 'package:employess_data/cubit/Cubit.dart';
import 'package:employess_data/screens/Employes_Screen.dart';
import 'package:employess_data/screens/add_employees_screen.dart';
import 'package:employess_data/widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'constants/utils.dart';
import 'cubit/current_employee_cubit.dart';
import 'cubit/previous_employee_cubit.dart';
import 'model/employee_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter<Employee>(EmployeeAdapter());
  await Hive.openBox(EMPLOYEE_TABLE);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => EmployeeCubit(),),
        BlocProvider(create: (BuildContext context) => CurrentEmployeeCubit()..currentEmployees,),
        BlocProvider(create: (BuildContext context) => PreviousEmployeeCubit()..previousEmployees,)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home:  const MyHomePage(title: 'Employee List'),
      ),
    );
  }
}



