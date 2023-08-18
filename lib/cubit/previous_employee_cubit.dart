
import 'package:flutter_bloc/flutter_bloc.dart';

import '../constants/helper.dart';
import '../model/employee_model.dart';

class PreviousEmployeeCubit extends Cubit<List<Employee>> {
  PreviousEmployeeCubit() : super([]);

  void get previousEmployees => emit(Helper.getPreviousEmployees());
}
