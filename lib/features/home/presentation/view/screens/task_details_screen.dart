import 'package:courses_app/features/home/presentation/view/widgets/editable_field.dart';
import 'package:courses_app/features/home/presentation/view/widgets/user_row.dart';
import 'package:courses_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import '../../../../../core/utils/styles/colors.dart';
import '../../../data/models/get_tasks_model.dart';
import '../../view_model/home_cubit.dart';
import '../widgets/deadline_edit_field.dart';
import '../widgets/partner_row.dart';
import '../widgets/project_row.dart';

class TaskDetailsScreen extends StatefulWidget{
  static const String routeName = "taskDetailsScreen";
  const TaskDetailsScreen({super.key});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  late TaskResult args;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as TaskResult;
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is EditTaskError) {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.grey[200],
              title: Text("Error", style: TextStyle(color: primaryColor)),
              content: Text(state.failure.errormsg, style: TextStyle(color: primaryColor)),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Okay", style: TextStyle(color: Colors.white))),
              ],
            ),
          );
        } else if (state is EditTaskLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator(color:Colors.green,)),
          );
        } else if (state is EditTaskSuccess) {
          Navigator.of(context).pop();
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(
                  child: Text(
                    "Task Edited Successfully",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 4),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(24),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
              ),
            );
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          surfaceTintColor: Colors.transparent,
          title: Text(AppLocalizations.of(context)!.taskDetails,style: TextStyle(
            fontSize: 24.sp,fontWeight: FontWeight.bold
          ),),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset("assets/images/add_task4.png",width: double.infinity,height: 300.h,),
              EditableField(
                controller: nameController,
                label: AppLocalizations.of(context)!.name,
                iconPath: "assets/images/id-card_6785365.png",
                initialValue: args.name ?? "",
                onSave: (value) {
                  context.read<HomeCubit>().editTask(taskId: args.id!, name: nameController.text);
                },
              ),
              SizedBox(height: 16.h,),
              ProjectRow(
                iconPath: "assets/images/project.png",
                label: AppLocalizations.of(context)!.project,
                initialValue: args.projectId?? "",
                onSave: (project) {
                  context.read<HomeCubit>().editTask(taskId: args.id!, projectId: project.id);
                },
              ),
              PartnerRow(
                iconPath: "assets/images/customer.png",
                label: AppLocalizations.of(context)!.partner,
                initialValue: args.partnerId ?? "",
                onSave: (partner) {
                  context.read<HomeCubit>().editTask(taskId: args.id!, partnerId: partner.id);
                },
              ),
              UserRow(
                iconPath: "assets/images/people_8532963.png",
                label: AppLocalizations.of(context)!.user,
                initialValue:args.userIds!.isEmpty?"no user":args.userIds?[0].name ?? "",
                onSave: (user) {
                  context.read<HomeCubit>().editTask(taskId: args.id!,userId: user.id);
                },
              ),
              EditableDateField(
                controller: dateController,
                label: AppLocalizations.of(context)!.deadline,
                iconPath: "assets/images/deadline_6863909.png", // use your date icon here
                initialValue: args.deadline ?? "", // or use a default value
                onSave: (value) {
                  context.read<HomeCubit>().editTask(
                    taskId: args.id!,
                    deadline: dateController.text,
                  );
                },
              ),
              SizedBox(height: 16.h,),
              EditableField(
                controller: descriptionController,
                label: AppLocalizations.of(context)!.description,
                iconPath: "assets/images/statistics_15301544.png",
                initialValue: removeHtmlTags(args.description??"No description"),
                onSave: (value) {
                  context.read<HomeCubit>().editTask(taskId: args.id!, description:descriptionController.text);
                },
              ),
              SizedBox(height: 16.h,),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical:8.h),
                      decoration: BoxDecoration(
                        color: secondPrimary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Image.asset("assets/images/calendar_591607.png", width: 24.w, height: 24.h),
                          SizedBox(width: 6.w),
                          Text(
                            AppLocalizations.of(context)!.date,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color:Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width:8.w),
                    Container(
                      width: 140.w,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:secondPrimary
                        )
                      ),
                      child: Center(
                        child: Text(_formatDate(args.date),style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color:Colors.black,
                        ),),
                      ),
                    ),
                  ]),
            ],
          ),
        ),
      ),
    );
  }
  String _formatDate(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) {
      return "No date";
    }
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } catch (e) {
      return "Invalid date";
    }
  }

  String removeHtmlTags(String? htmlString) {
    if (htmlString == null) return "No description";
    return parse(htmlString).body?.text ?? "No description";
  }
}
