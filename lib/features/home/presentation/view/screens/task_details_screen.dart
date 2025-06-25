import 'package:courses_app/features/home/presentation/view/widgets/user_row.dart';
import 'package:courses_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html/parser.dart';
import '../../../../../core/utils/styles/colors.dart';
import '../../../data/models/get_tasks_model.dart';
import '../../view_model/home_cubit.dart';
import '../widgets/editable_field.dart';
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
              SizedBox(height: 8.h,),
              ProjectRow(
                iconPath: "assets/images/project.png",
                label: AppLocalizations.of(context)!.project,
                initialValue: args.projectId?? "",
                onSave: (project) {
                  context.read<HomeCubit>().editTask(taskId: args.id!, projectId: project.id);
                },
              ),
              SizedBox(height: 8.h,),
              PartnerRow(
                iconPath: "assets/images/customer.png",
                label: AppLocalizations.of(context)!.partner,
                initialValue: args.partnerId ?? "",
                onSave: (partner) {
                  context.read<HomeCubit>().editTask(taskId: args.id!, partnerId: partner.id);
                },
              ),
              SizedBox(height: 8.h,),
              UserRow(
                iconPath: "assets/images/people_8532963.png",
                label: AppLocalizations.of(context)!.user,
                initialValue:args.userIds!.isEmpty?"no user":args.userIds?[0].name ?? "",
                onSave: (user) {
                  context.read<HomeCubit>().editTask(taskId: args.id!,userId: user.id);
                },
              ),
              SizedBox(height: 8.h,),
              EditableField(
                controller: descriptionController,
                label: AppLocalizations.of(context)!.description,
                iconPath: "assets/images/statistics_15301544.png",
                initialValue: removeHtmlTags(args.description??"No description"),
                keyboardType: TextInputType.number,
                onSave: (value) {
                  context.read<HomeCubit>().editTask(taskId: args.id!, description:descriptionController.text);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String removeHtmlTags(String? htmlString) {
    if (htmlString == null) return "No description";
    return parse(htmlString).body?.text ?? "No description";
  }
}
