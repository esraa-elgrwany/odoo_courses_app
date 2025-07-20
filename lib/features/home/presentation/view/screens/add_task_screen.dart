import 'package:courses_app/core/utils/styles/colors.dart';
import 'package:courses_app/features/home/presentation/view/screens/tasks_screen.dart';
import 'package:courses_app/features/home/presentation/view/widgets/button_widget.dart';
import 'package:courses_app/features/home/presentation/view/widgets/drop_down_container.dart';
import 'package:courses_app/features/home/presentation/view/widgets/partner_dialog.dart';
import 'package:courses_app/features/home/presentation/view/widgets/text_form_item.dart';
import 'package:courses_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../data/models/get_partner_model.dart';
import '../../../data/models/get_project_model.dart';
import '../../../data/models/get_user_model.dart';
import '../../view_model/home_cubit.dart';
import '../widgets/project_dialog.dart';
import '../widgets/user_dialog.dart';

class AddTaskScreen extends StatefulWidget {
  static const String routeName = "AddTask";

  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  UserResult? selectedUser;
  bool userSelected = true;
  ProjectResult? selectedProject;
  bool projectSelected = true;
  PartnerResult? selectedPartner;
  bool partnerSelected = true;
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController deadlineController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          bool isLoading = state is AddTaskLoading;
          return Stack(
            children: [
              Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  surfaceTintColor: Colors.transparent,
                  centerTitle: true,
                  title: Text(
                    AppLocalizations.of(context)!.addNewTask,
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/add_task4.png",
                              width: double.infinity,
                              height: 240.h,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              height:8.h,
                            ),
                            TextFormItem(
                                controller: nameController,
                                hint: AppLocalizations.of(context)!.name,
                                maxLine: 1,
                                icon: Icons.edit,
                                validateTxt: "please enter task name"),
                            SizedBox(
                              height: 16.h,
                            ),
                            TextFormItem(
                                controller: descriptionController,
                                hint: AppLocalizations.of(context)!.description,
                                maxLine: 1,
                                icon: Icons.edit,
                                validateTxt: "please enter task description"),
                            SizedBox(
                              height: 16.h,
                            ),
                            InkWell(
                                onTap: () {
                                  _showUserSelectionDialog();
                                },
                                child: DropDownContainer(
                                    text: selectedUser?.name ?? AppLocalizations.of(context)!.selectUser)),
                            SizedBox(
                              height: 16.h,
                            ),
                            InkWell(
                                onTap: () {
                                  _showProjectSelectionDialog();
                                },
                                child: DropDownContainer(
                                    text: selectedProject?.name ??
                                        AppLocalizations.of(context)!.selectProject)),
                            SizedBox(
                              height: 16.h,
                            ),
                            InkWell(
                                onTap: () {
                                  _showPartnerSelectionDialog();
                                },
                                child: DropDownContainer(
                                    text: selectedPartner?.name ??
                                        AppLocalizations.of(context)!.selectPartner)),
                            SizedBox(
                              height: 16.h,
                            ),
                            InkWell(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2100),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: primaryColor,
                                          onPrimary: Colors.white,
                                          onSurface: Colors.black,
                                        ),
                                        dialogBackgroundColor: Colors.white,
                                      ),
                                      child: child!,
                                    );
                                  },
                                );

                                if (pickedDate != null) {
                                  deadlineController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                                }
                              },
                              child: AbsorbPointer(
                                child: TextFormItem(
                                  controller: deadlineController,
                                  hint: AppLocalizations.of(context)!.deadline,
                                  maxLine: 1,
                                  icon: Icons.calendar_today,
                                  validateTxt: "please select deadline",
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 32.h,
                            ),
                            BlocConsumer<HomeCubit, HomeState>(
                              listener: (context, state) {
                                if (state is AddTaskError) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: Colors.grey[200],
                                      title: Text(
                                        "Error",
                                        style: TextStyle(color: primaryColor),
                                      ),
                                      content: Text(
                                        state.failures.errormsg,
                                        style: TextStyle(color: primaryColor),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("okay",
                                                style: TextStyle(
                                                    color: Colors.white))),
                                      ],
                                    ),
                                  );
                                } else if (state is AddTaskSuccess) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Center(
                                          child: Text(
                                            "Task Added Successfully",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.sp),
                                          ),
                                        ),
                                        backgroundColor: Colors.green,
                                        duration: Duration(seconds: 4),
                                        behavior: SnackBarBehavior.floating,
                                        margin: EdgeInsets.all(24),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 4)),
                                  );
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => TaskScreen()),
                                  );
                                }
                              },
                              builder:(context, state) {
                                return InkWell(
                                    onTap: () {
                                      onConfirm();
                                      if (userSelected &&
                                          partnerSelected &&
                                          projectSelected) {
                                        HomeCubit.get(context).addTask(
                                          name: nameController.text,
                                          description: descriptionController
                                              .text,
                                          userId: selectedUser?.id ?? 0,
                                          partnerId: selectedPartner?.id ?? 0,
                                          projectId: selectedProject?.id ?? 0,
                                          deadline: deadlineController.text
                                        );
                                      }
                                    },
                                    child: ButtonWidget(txt: AppLocalizations.of(context)!.addTask));
                              }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (isLoading)
                Container(
                  color: Colors.black.withOpacity(0.5),
                  // Semi-transparent background
                  child: Center(
                    child: CircularProgressIndicator(color: Colors.green),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _showUserSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => HomeCubit()..getUsers(),
        child: UserDialog(
          onUserSelected: (selectedUser) {
            setState(() {
              this.selectedUser = selectedUser;
            });
          },
        ),
      ),
    );
  }

  void _validateUserSelection() {
    setState(() {
      userSelected =
          selectedUser?.name != null && selectedUser!.name!.isNotEmpty;
    });

    if (!userSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select a user.",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center),
          backgroundColor: redColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(12)),
          margin:
              EdgeInsets.only(bottom: 80, left: 20, right: 20), // Adjust margin
        ),
      );
    }
  }

  void _showProjectSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => HomeCubit()..getProjects(),
        child: ProjectDialog(
          onProjectSelected: (selectedProject) {
            setState(() {
              this.selectedProject = selectedProject;
            });
          },
        ),
      ),
    );
  }

  void _validateProjectSelection() {
    setState(() {
      projectSelected =
          selectedProject?.name != null && selectedProject!.name!.isNotEmpty;
    });

    if (!projectSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select a project.",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center),
          backgroundColor: redColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(12)),
          behavior: SnackBarBehavior.floating,
          margin:
              EdgeInsets.only(bottom: 80, left: 20, right: 20), // Adjust margin
        ),
      );
    }
  }

  void _showPartnerSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => HomeCubit()..getPartners(),
        child: PartnerDialog(
          onPartnerSelected: (selectedPartner) {
            setState(() {
              this.selectedPartner = selectedPartner;
            });
          },
        ),
      ),
    );
  }

  void _validatePartnerSelection() {
    setState(() {
      partnerSelected =
          selectedPartner?.name != null && selectedPartner!.name!.isNotEmpty;
    });

    if (!partnerSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select a partner.",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center),
          backgroundColor: redColor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(12)),
          margin:
              EdgeInsets.only(bottom: 80, left: 20, right: 20), // Adjust margin
        ),
      );
    }
  }

  void onConfirm() {
    formKey.currentState!.validate();
    _validateUserSelection();
    _validateProjectSelection();
    _validatePartnerSelection();
    formKey.currentState!.validate();
  }

}
