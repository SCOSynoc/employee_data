import 'package:employess_data/constants/colors.dart';
import 'package:employess_data/cubit/previous_employee_cubit.dart';
import 'package:employess_data/widgets/common_text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/utils.dart';
import '../cubit/Cubit.dart';
import '../main.dart';
import '../model/employee_model.dart';

class PreviousEmployeeList extends StatelessWidget {
  const PreviousEmployeeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     context.read<PreviousEmployeeCubit>().previousEmployees;
    return BlocBuilder<PreviousEmployeeCubit, List<Employee>>(
      builder: (context, state) {
        if(state.isEmpty){
          return Center(child: AspectRatio(
              aspectRatio: 1,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SvgPicture.asset('$assetPath/no_data_txt.svg',width:100 , height: 100,),
              )),);
        }
        return ListView.builder(
            shrinkWrap: true,
            itemCount: state.length,
            itemBuilder: (context, index) {
              final data = state[index];
              return Dismissible(
                key: UniqueKey(),
                background:  ColoredBox(
                  color: Colors.red,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: SvgPicture.asset("$assetPath/delete_icon.svg", color: Colors.white,),
                    ),
                  ),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (DismissDirection direction) {
                  context.read<EmployeeCubit>().removeData(data.id, context, data);
                  /*navigateAndRemovePush(context, MyApp());*/

                },
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(fontSize: 16, wtg: FontWeight.w500, color: appFontPrimaryColor, text: "${data.name}"),
                            const SizedBox(height: 6,),
                            TextWidget(fontSize: 14, wtg: FontWeight.w400, color: appSecondaryFontColor, text:  "${data.role}"),
                            const SizedBox(height: 6,),
                            TextWidget(fontSize: 12, wtg: FontWeight.w400, color: appSecondaryFontColor, text: "${data.fromDate}-${data.toDate}"),
                          ],
                        ),
                      ),

                      Divider(thickness: 0.5, color: appSecondaryFontColor,)
                    ],
                  ),
                ),
              );
            });
      }
    );
  }
}
