import 'package:courses_app/core/utils/styles/colors.dart';
import 'package:courses_app/features/home/data/models/get_state.dart';
import 'package:courses_app/features/home/data/models/get_status.dart';
import 'package:courses_app/features/home/presentation/view/screens/course_details_screen.dart';
import 'package:courses_app/features/home/presentation/view/widgets/course_card.dart';
import 'package:courses_app/features/home/presentation/view/widgets/search_bar.dart';
import 'package:courses_app/features/home/presentation/view/widgets/state_dialog.dart';
import 'package:courses_app/features/home/presentation/view/widgets/status_dialog.dart';
import 'package:courses_app/features/home/presentation/view_model/home_cubit.dart';
import 'package:courses_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/floating_button.dart';
import 'add_course_screen.dart';


class CourseScreen extends StatefulWidget {
  static const String routeName = "courseScreen";

  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  TextEditingController searchController = TextEditingController();
  String searchCategory="name";
  String ?searchBy;
  StateResult? selectedState;
  StatusResult? selectedStatus;
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
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.w600
          ),
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
                size: 24.sp,
              )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: 16,
                        right:16
                    ),
                    child:
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.searchBy,
                        labelStyle:TextStyle(fontSize: 14.sp,color:Colors.black) ,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: secondPrimary)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: secondPrimary)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: secondPrimary)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      value: searchBy,
                      onChanged: (value) {
                        setState(() {
                          searchBy = value;
                          if(value==AppLocalizations.of(context)!.name){
                            searchCategory = "name";
                          }else if(value==AppLocalizations.of(context)!.state){
                            searchCategory ="state_id";
                            _showStateSelectionDialog();
                          }else if(value==AppLocalizations.of(context)!.status){
                            searchCategory ="status";
                            _showStatusSelectionDialog();
                          }else if(value==AppLocalizations.of(context)!.bookingRes){
                            searchCategory ="booking_responsable";
                          }else if(value==AppLocalizations.of(context)!.batchNum){
                            searchCategory ="batch_num";
                          }
                        });
                      },
                      dropdownColor: Colors.grey[100],
                      iconEnabledColor: primaryColor,
                      style: TextStyle(fontSize: 16.sp,color: Colors.black),
                      items: [
                        AppLocalizations.of(context)!.name,
                        AppLocalizations.of(context)!.state,
                        AppLocalizations.of(context)!.status,
                         AppLocalizations.of(context)!.bookingRes,
                        AppLocalizations.of(context)!.batchNum,
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
                      if (searchController.text.isNotEmpty) {
                        context.read<HomeCubit>().getCourses(query: searchController.text,searchCat: searchCategory);
                      }else {
                        context.read<HomeCubit>().getCourses();
                      }
                    },
                    onClear: () {
                      setState(() {
                          searchController.clear();
                          context.read<HomeCubit>().getCourses();
                      });
                    },
                  ),
                ],
              ),
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
  void _showStatusSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => HomeCubit()..getStatus(),
        child: StatusDialog(
          onStatusSelected: (status) {
            setState(() {
              selectedStatus = status;
              searchCategory = "status";
            });
            context.read<HomeCubit>().getCourses(
              query: status.name ?? "",
              searchCat: "status",
            );
          },
        ),
      ),
    );
  }
  void _showStateSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) => BlocProvider(
        create: (context) => HomeCubit()..getStates(),
        child: StateDialog(
          onStateSelected: (state) {
            setState(() {
              selectedState = state;
              searchCategory = "state_id";
            });
            context.read<HomeCubit>().getCourses(
              query: state.name??"",
              searchCat: "state_id",
            );
          },
        ),
      ),
    );
  }
}

