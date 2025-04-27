
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:html/parser.dart';
import '../../../../../core/utils/styles/colors.dart';
import '../../../data/models/get_tasks_model.dart';

class TaskDetailsScreen extends StatelessWidget{
  static const String routeName = "taskDetailsScreen";
  const TaskDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TaskResult args=
    ModalRoute.of(context)?.settings.arguments as TaskResult;
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.taskDetails,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/add_task4.png",
                  width: double.infinity,
                  height: 240,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                    height: 40,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: secondPrimary,
                        borderRadius: BorderRadiusDirectional.circular(16)
                    ),
                    child:Row(
                      children: [
                        Image.asset("assets/images/id-card_6785365.png",width: 24,height: 24,),
                        SizedBox(width: 4,),
                        Text(AppLocalizations.of(context)!.name,style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),),
                      ],
                    ),),
                    SizedBox(width: 8,),
                  Flexible(
              flex:14,
              child: Column(children:[Text(args.name??"no name",style: TextStyle(
                      fontSize: 16,
                    ),)])),
               ]),
                const SizedBox(height: 16),
                Row(
                  children: [Container(
                    height: 40,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: secondPrimary,
                        borderRadius: BorderRadiusDirectional.circular(16)
                    ),
                    child:Row(
                      children: [
                        Image.asset("assets/images/project.png",width: 24,height: 24,),
                        SizedBox(width: 4,),
                        Text(AppLocalizations.of(context)!.project,style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),),
                      ],
                    ),),
                    SizedBox(width: 8,),
            Flexible(
              flex:14,
              child: Column(children:[Text("${args.projectId??"no project"}",style: TextStyle(
                      fontSize: 16,
                    ),)]))],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [Container(
                    height: 40,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: secondPrimary,
                        borderRadius: BorderRadiusDirectional.circular(16)
                    ),
                    child:Row(
                      children: [
                        Image.asset("assets/images/customer.png",width: 24,height: 24,),
                        SizedBox(width: 4,),
                        Text(AppLocalizations.of(context)!.partner,style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),),
                      ],
                    ),),
                    SizedBox(width: 8,),
            Flexible(
              flex:14,
              child: Column(children:[
                Text("${args.partnerId??"no partner"}",style: TextStyle(
                      fontSize: 16,
                    ))]
              )
            )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [Container(
                    height: 40,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: secondPrimary,
                        borderRadius: BorderRadiusDirectional.circular(16)
                    ),
                    child:Row(
                      children: [
                        Image.asset("assets/images/people_8532963.png",width: 24,height: 24,),
                        SizedBox(width: 4,),
                        Text(AppLocalizations.of(context)!.user,style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),),
                      ],
                    ),),
                    SizedBox(width: 8,),
            Flexible(
              flex:14,
              child: Column(children:[Text(args.userIds != null && args.userIds!.isNotEmpty
                        ? args.userIds![0].name ?? "No user"
                        :"No user",style: TextStyle(
                      fontSize: 16,
                    ),)]))],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [Container(
                    height: 40,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: secondPrimary,
                        borderRadius: BorderRadiusDirectional.circular(16)
                    ),
                    child:Row(
                      children: [
                        Image.asset("assets/images/finder_3596476.png",width: 24,height: 24,),
                        SizedBox(width: 4,),
                        Text(AppLocalizations.of(context)!.description,style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),),
                      ],
                    ),),
                    SizedBox(width: 8,),
            Flexible(
              flex:14,
              child: Column(children:[Text(removeHtmlTags(args.description),style: TextStyle(
                      fontSize: 16,
                    ),)]))],
                ),
              ],
            ),
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
