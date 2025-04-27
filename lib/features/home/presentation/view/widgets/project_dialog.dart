import 'package:courses_app/features/home/data/models/get_project_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../view_model/home_cubit.dart';

class ProjectDialog extends StatefulWidget{
  final Function(ProjectResult project) onProjectSelected;
  const ProjectDialog({super.key,required this.onProjectSelected});

  @override
  State<ProjectDialog> createState() => _ProjectDialogState();
}

class _ProjectDialogState extends State<ProjectDialog> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.onBackground,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isSearching
              ? Expanded(
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                if (searchController.text.isNotEmpty) {
                  context.read<HomeCubit>().getProjects(query: searchController.text);
                }
              },
              decoration: InputDecoration(
                hintText: "Search Projects...",
                border: InputBorder.none,
              ),
            ),
          )
              : Text(
            AppLocalizations.of(context)!.selectProject,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  searchController.clear();
                  context.read<HomeCubit>().getProjects();
                }
              });
            },
          ),
        ],
      ),
      content: SizedBox(
        height: MediaQuery.of(context).size.height / 1.6,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is GetProjectLoading) {
              return Center(
                child: CircularProgressIndicator(color: Colors.green),
              );
            } else if (state is GetProjectError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.red, size: 50),
                    SizedBox(height: 12),
                    Text(
                      "An error occurred.",
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  ],
                ),
              );
            } else if (state is GetProjectSuccess) {
              final projects =context.read<HomeCubit>().projects;
              if (projects.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/project.png",width: 24,height: 24,),
                      SizedBox(height: 12),
                      Text(
                        "No Projects Found",
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }
              return ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Theme.of(context).colorScheme.primary,
                  thickness: 1,
                  endIndent: 8,
                  indent: 8,
                ),
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  final project = projects[index];
                  return ListTile(
                    leading: Image.asset("assets/images/project.png",width: 24,height: 24,),
                    title: Text(project.name ?? "No Name",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    onTap: () {
                      widget.onProjectSelected(project);
                      Navigator.pop(context);
                    },
                  );
                },
              );
            }
            return SizedBox(); // Default empty state
          },
        ),
      ),
    );
  }
}
