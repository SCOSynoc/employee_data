import 'dart:developer';

import 'package:employess_data/constants/colors.dart';
import 'package:employess_data/constants/utils.dart';
import 'package:employess_data/constants/validate_factory.dart';
import 'package:employess_data/cubit/Cubit.dart';
import 'package:employess_data/main.dart';
import 'package:employess_data/model/employee_model.dart';
import 'package:employess_data/screens/Employes_Screen.dart';
import 'package:employess_data/widgets/common_text_field.dart';
import 'package:employess_data/widgets/common_text_widget.dart';
import 'package:employess_data/widgets/table_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uuid/uuid.dart';

import '../widgets/common_button.dart';
import '../widgets/selector_container.dart';


class AddEmployeesForm extends StatefulWidget {
  const AddEmployeesForm({Key? key, this.data}) : super(key: key);
  final Employee? data;
  @override
  State<AddEmployeesForm> createState() => _AddEmployeesFormState();
}

class _AddEmployeesFormState extends State<AddEmployeesForm> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController positionController = TextEditingController();



  @override
  void initState() {
    super.initState();
    nameController.text = widget.data?.name ?? "";
    roleNotifier.value = widget.data?.role ?? "";
    dateNotifier.value = widget.data?.fromDate ?? "";
    noDateNotifier.value = widget.data?.toDate ?? "";

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             TextWidget(fontSize: 18, wtg: FontWeight.w500,
              color: Colors.white, text: widget.data != null ? 'Edit Employee details':'Add Employees Details',),
            Visibility(
                visible: widget.data != null,
                child: IconButton(onPressed: () {
                  if(widget.data != null){
                    context.read<EmployeeCubit>().removeData(widget.data?.id ?? "", context, widget.data!);
                    navigateAndRemovePush(context, MyHomePage(title: "Employee List"));
                  }
                },
                    icon: SvgPicture.asset('$assetPath/delete_icon.svg')
                ))
          ],
        ),
        backgroundColor: appPrimaryColor,
      ),
      body: Container(
        height: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: AspectRatio(
                aspectRatio: 1,
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: CommonTextField(
                              obscureText: false,
                              label: widget.data?.name ?? "Employee Name",
                              prefixIcon: SvgPicture.asset("$assetPath/person.svg", width: 24, height: 24,),
                              controller: nameController)
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                        child:  InkWell(
                          onTap: () {
                            showCupertinoModalPopup(context: context, builder: (context) => CupertinoActionSheet(
                              actions: List.generate(rolesList.length, (index) => CupertinoActionSheetAction(onPressed: () {
                                roleNotifier.value = rolesList[index];
                                Navigator.pop(context);
                              },
                                  child: TextWidget(fontSize: 16, wtg: FontWeight.w400, color: appFontPrimaryColor, text: rolesList[index]))),));
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              child: ValueListenableBuilder(
                                builder: (context, value, child) {
                                  return DropdownContainer(
                                    label: "$value",
                                    prefixIcon: SvgPicture.asset("$assetPath/role_icon.svg", width: 24, height: 24,),
                                    suffixIcon: SvgPicture.asset("$assetPath/dropdown_arrow.svg",
                                      width: 20, height: 20,
                                    ), from: 'role',
                                  );
                                }, valueListenable: roleNotifier,
                              )),
                        )
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                      child: SizedBox(
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex:5,
                              child: InkWell(
                                onTap: (){
                                  showDialog(
                                    context: context, builder: (context) =>
                                      AspectRatio(
                                        aspectRatio: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                          child: Dialog(
                                            clipBehavior: Clip.antiAlias,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            insetPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.15),
                                            child: SingleChildScrollView(
                                              child: Container(
                                                  width: 396,
                                                  height: 500,
                                                  decoration: const BoxDecoration(borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(16),
                                                      topRight: Radius.circular(16)
                                                  )
                                                  ),
                                                  child: TableCalendarCard(list: today_recom, from: 'today',)),
                                            ),
                                          ),
                                        ),
                                      ),
                                  );
                                },
                                child: ValueListenableBuilder(
                                  builder: (context, value, child) {
                                    return DropdownContainer(
                                      label: "$value",
                                      prefixIcon: SvgPicture.asset("$assetPath/calendar.svg", width: 24, height: 24,), from: 'Today',
                                    );
                                  }, valueListenable: dateNotifier,
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: SvgPicture.asset("$assetPath/arrow_right.svg", width: 23, height: 23,)),
                            Expanded(
                              flex: 5,
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context, builder: (context) =>
                                      AspectRatio(
                                        aspectRatio: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                          child: Dialog(
                                            clipBehavior: Clip.antiAlias,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            insetPadding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.15),
                                            child: SingleChildScrollView(
                                              child: Container(
                                                  width: 396,
                                                  height: 500,
                                                  decoration: const BoxDecoration(borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(16),
                                                      topRight: Radius.circular(16)
                                                  )
                                                  ),
                                                  child: TableCalendarCard(list: noDate_Recom, from: 'nodate',)),
                                            ),
                                          ),
                                        ),
                                      ),
                                  );
                                },
                                child: ValueListenableBuilder(
                                  builder: (context, value, child) {
                                    return DropdownContainer(
                                      label: "$value",
                                      prefixIcon: SvgPicture.asset("$assetPath/calendar.svg", width: 24, height: 24, ), from: 'No date',
                                    );
                                  }, valueListenable: noDateNotifier,
                                ),
                              ),
                            ),

                          ],),),
                    ),



                  ],),
              ),
            ),
            Positioned(
              bottom: 10,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Divider(
                      color: Colors.grey[200],
                      thickness: 1.5,
                      height: 10,

                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(child:
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CommonElevatedButton(text: "Cancel", color: appPrimaryColor, buttonColor: appSecondaryColor, onPressed: (){
                            Navigator.pop(context);
                          },),
                          const SizedBox(width: 14,),
                          CommonElevatedButton(text: "Save", color: Colors.white, buttonColor: appPrimaryColor, onPressed: () {
                            try{
                              Validate(nameController.text, roleNotifier.value, dateNotifier.value).commonFunction(context);
                              if(widget.data == null){
                                String uuid = const Uuid().v1();
                                Employee employee = Employee(id: uuid, name: nameController.text, role: roleNotifier.value, fromDate: dateNotifier.value, toDate: noDateNotifier.value);
                                context.read<EmployeeCubit>().addEmployee(employee);
                                navigateAndRemovePush(context, MyApp());
                              }else{
                                print("no data data is ${noDateNotifier.value}");
                                Employee employee = Employee(id: widget.data?.id ?? "", name: nameController.text,
                                    role: roleNotifier.value, fromDate: dateNotifier.value, toDate: noDateNotifier.value);
                                context.read<EmployeeCubit>().updateEmployees(updEmployee: employee, empId: widget.data?.id ?? "",);
                                navigateAndRemovePush(context, MyApp());
                              }
                            }catch(e){
                              log("This is an error $e");
                            }
                            /*BlocProvider.of<EmployeeCubit>(context).addEmployee(employee);*/
                          },)
                        ],) ,),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

  }
}

