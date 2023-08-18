import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/helper.dart';
import '../model/employee_model.dart';

class CurrentEmployeeCubit extends Cubit<List<Employee>> {
  CurrentEmployeeCubit() : super([]);

  void get currentEmployees => emit(Helper.getCurrentEmployees());
}
