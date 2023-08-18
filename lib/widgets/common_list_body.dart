
import 'package:employess_data/constants/utils.dart';
import 'package:employess_data/cubit/Cubit.dart';
import 'package:employess_data/widgets/current_employee_list.dart';
import 'package:employess_data/widgets/previous_employee_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/colors.dart';
import 'common_text_widget.dart';

class CommonBody extends StatelessWidget {
  const CommonBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    context.read<EmployeeCubit>().checkEmployeeRecords();
    return BlocBuilder<EmployeeCubit, EmployeeState>(
      builder: (BuildContext context, state) {
        if(state.employees.isEmpty){
          return Center(child: Container(child:  Padding(
            padding: const EdgeInsets.all(58.0),
            child: SvgPicture.asset("assets/images/no_data_txt.svg", width: 200, height: 200,),
          ),));
        }
        return AspectRatio(
          aspectRatio: 1,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    height: 56,
                    width: double.infinity,
                    color: headContainer,
                    child: const TextWidget(fontSize: 16, wtg: FontWeight.w500, color: appPrimaryColor, text: "Current Employees"),
                  ),
                   Container(
                       height: MediaQuery.of(context).size.height*0.40,
                       child: CurrentEmployeeList()),
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    height: 56,
                    color: headContainer,
                    child: const TextWidget(fontSize: 16, wtg: FontWeight.w500, color: appPrimaryColor, text: "Previous Employees"),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height*0.40,
                      child: PreviousEmployeeList()),
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    height: 58,
                    color: headContainer,
                    child: const TextWidget(fontSize: 15, wtg: FontWeight.w500, color: appSecondaryFontColor, text: "Swipe left to delete"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}