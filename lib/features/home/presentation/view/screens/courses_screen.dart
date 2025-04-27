import 'package:courses_app/features/home/presentation/view/screens/course_details_screen.dart';
import 'package:courses_app/features/home/presentation/view/widgets/course_card.dart';
import 'package:courses_app/features/home/presentation/view/widgets/search_bar.dart';
import 'package:courses_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/floating_button.dart';
import 'add_course_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CourseScreen extends StatefulWidget {
  static const String routeName = "courseScreen";

  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    context.read<HomeCubit>().getCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            AppLocalizations.of(context)!.courses,
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
              child: Icon(
                Icons.arrow_back_outlined,
              )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SearchBarWidget(
              controller: searchController,
              onSearch: (query) {
                if (searchController.text.isNotEmpty) {
                  context.read<HomeCubit>().getCourses(query: searchController.text);
                }
              },
              onClear: () {
                setState(() {
                    searchController.clear();
                    context.read<HomeCubit>().getCourses();
                });
              },
            ),
            SizedBox(
              height: 8,
            ),
            BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
              if (state is GetCoursesLoading) {
                return Center(
                  child: CircularProgressIndicator(color: Colors.green),
                );
              }
              else if (state is GetCoursesError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
              } else if (state is GetCoursesSuccess) {
                final courses = context.read<HomeCubit>().courses;
                if (courses.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.book_outlined,
                            color: Colors.grey, size: 50),
                        SizedBox(height: 12),
                        Text(
                          "No Courses Found",
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, CourseDetailsScreen.routeName,
                              arguments:courses[index]);
                        },
                          child: CourseCard(index: index,));
                    },
                  ),
                );
              }
              return SizedBox();
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingButton(AddCourseScreen.routeName),
    );
  }
}
