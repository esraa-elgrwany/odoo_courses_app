import 'dart:async';

import 'package:courses_app/features/home/presentation/view/screens/add_task_screen.dart';
import 'package:courses_app/features/home/presentation/view/screens/task_details_screen.dart';
import 'package:courses_app/features/home/presentation/view/widgets/floating_button.dart';
import 'package:courses_app/features/home/presentation/view/widgets/search_bar.dart';
import 'package:courses_app/features/home/presentation/view/widgets/task_card.dart';
import 'package:courses_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class TaskScreen extends StatefulWidget {
  static const String routeName = "taskScreen";

  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TextEditingController searchController = TextEditingController();

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
        title: Text(
          AppLocalizations.of(context)!.tasks,
        ),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SearchBarWidget(
              controller: searchController,
              onSearch: (query) {
                if (query.isNotEmpty) {
                  context.read<HomeCubit>().getTasks(query: query);
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
                          children: const [
                            Icon(Icons.task_outlined,
                                color: Colors.grey, size: 50),
                            SizedBox(height: 12),
                            Text(
                              "No Tasks Found",
                              style: TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    }
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
}
