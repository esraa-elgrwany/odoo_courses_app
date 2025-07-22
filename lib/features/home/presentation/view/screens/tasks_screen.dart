import 'package:courses_app/core/utils/styles/colors.dart';
import 'package:courses_app/features/home/data/models/get_partner_model.dart';
import 'package:courses_app/features/home/data/models/get_project_model.dart';
import 'package:courses_app/features/home/data/models/get_user_model.dart';
import 'package:courses_app/features/home/presentation/view/screens/add_task_screen.dart';
import 'package:courses_app/features/home/presentation/view/screens/calender_task_view.dart';
import 'package:courses_app/features/home/presentation/view/screens/task_details_screen.dart';
import 'package:courses_app/features/home/presentation/view/widgets/floating_button.dart';
import 'package:courses_app/features/home/presentation/view/widgets/partner_dialog.dart';
import 'package:courses_app/features/home/presentation/view/widgets/project_dialog.dart';
import 'package:courses_app/features/home/presentation/view/widgets/search_bar.dart';
import 'package:courses_app/features/home/presentation/view/widgets/task_card.dart';
import 'package:courses_app/features/home/presentation/view/widgets/user_dialog.dart';
import 'package:courses_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:courses_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskScreen extends StatefulWidget {
  static const String routeName = "taskScreen";

  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TextEditingController searchController = TextEditingController();
  String searchCategory = "name";
  String? searchBy;
  UserResult? selectedUser;
  ProjectResult? selectedProject;
  PartnerResult? selectedPartner;
  bool _isCalendarView = false;

  @override
  void initState() {
    context.read<HomeCubit>().getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //task screen
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.tasks,
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold)),
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_outlined),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isCalendarView ? Icons.list : Icons.calendar_month_rounded,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _isCalendarView = !_isCalendarView;
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isCalendarView==false)
        SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 16, right: 16),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText:AppLocalizations.of(context)!.searchBy,
                        labelStyle:
                            TextStyle(fontSize: 14.sp, color: Colors.black),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: secondPrimary)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: secondPrimary)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: secondPrimary)),
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      value: searchBy,
                      onChanged: (value) {
                        setState(() {
                          searchBy = value;
                          if (value == AppLocalizations.of(context)!.name) {
                            searchCategory = "name";
                          } else if (value == AppLocalizations.of(context)!.user) {
                            searchCategory = "user_ids";
                            _showUserSelectionDialog();
                          } else if (value == AppLocalizations.of(context)!.project) {
                            searchCategory = "project_id";
                            _showProjectSelectionDialog();
                          } else if (value == AppLocalizations.of(context)!.partner) {
                            searchCategory = "partner_id";
                            _showPartnerSelectionDialog();
                          } else if (value == AppLocalizations.of(context)!.description) {
                            searchCategory = "description";
                          }
                        });
                      },

                      dropdownColor: Colors.grey[100],
                      iconEnabledColor: primaryColor,
                      style: TextStyle(fontSize: 16.sp, color: Colors.black),
                      items: [
                        AppLocalizations.of(context)!.name,
                        AppLocalizations.of(context)!.user,
                        AppLocalizations.of(context)!.project,
                        AppLocalizations.of(context)!.partner,
                        AppLocalizations.of(context)!.description,
                      ].map((category) {
                        return DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SearchBarWidget(
                    controller: searchController,
                    onSearch: (query) {
                      if (query.isNotEmpty) {
                        context
                            .read<HomeCubit>()
                            .getTasks(query: query, searchCat: searchCategory);
                      } else {
                        context.read<HomeCubit>().getTasks();
                      }
                    },
                    onClear: () {
                      setState(() {
                        searchController.clear();
                        context.read<HomeCubit>().getTasks();
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is GetTasksLoading) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    );
                  } else if (state is GetTasksError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.warning_amber_rounded,
                              color: Colors.red, size: 50),
                          SizedBox(height: 12),
                          Text(
                            "An error occurred.",
                            style: TextStyle(color: Colors.red, fontSize: 18),
                          ),
                        ],
                      ),
                    );
                  } else if (state is GetTasksSuccess) {
                    final tasks = context.read<HomeCubit>().tasks;
                    if (tasks.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.task_outlined,
                                color: Colors.grey, size: 40.sp),
                            SizedBox(height: 8.h),
                            Text(
                              "No Tasks Found",
                              style: TextStyle(
                                  fontSize: 18.sp, color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    }
                    if (_isCalendarView) {
                      return TaskCalendarView(tasks: tasks);
                    } else {
                      return ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                TaskDetailsScreen.routeName,
                                arguments: tasks[index],
                              );
                            },
                            child: TaskCard(index: index),
                          );
                        },
                      );
                    }
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingButton(AddTaskScreen.routeName),
    );
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
              searchCategory = "partner_id";
              searchController.clear();
            });
            context.read<HomeCubit>().getTasks(
                  query: selectedPartner.name ?? "",
                  searchCat: "partner_id",
                );
          },
        ),
      ),
    );
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
              searchCategory = "project_id";
              searchController.clear();
            });
            context.read<HomeCubit>().getTasks(
                  query: selectedProject.name ?? "",
                  searchCat: "project_id",
                );
          },
        ),
      ),
    );
  }

  void _showUserSelectionDialog() {
    showDialog(
      context: context,
      builder: (_) => BlocProvider(
        create: (_) => HomeCubit()..getUsers(),
        child: Builder(
          builder: (dialogContext) => UserDialog(
            onUserSelected: (user) {
              setState(() {
                selectedUser = user;
                searchCategory = "user_ids";
                searchController.clear();
              });
              context.read<HomeCubit>().getTasks(
                    query: user.name ?? "",
                    searchCat: "user_ids",
                  );
            },
          ),
        ),
      ),
    );
  }
}
