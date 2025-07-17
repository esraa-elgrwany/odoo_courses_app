import 'package:courses_app/features/home/data/models/delete_course.dart';
import 'package:courses_app/features/home/data/models/edit_course_model.dart';
import 'package:courses_app/features/home/data/models/edit_task_model.dart';
import 'package:courses_app/features/home/data/models/get_courses_model.dart';
import 'package:courses_app/features/home/data/models/get_know_us_model.dart';
import 'package:courses_app/features/home/data/models/get_partner_model.dart';
import 'package:courses_app/features/home/data/models/get_project_model.dart';
import 'package:courses_app/features/home/data/models/get_state.dart';
import 'package:courses_app/features/home/data/models/get_status.dart';
import 'package:courses_app/features/home/data/models/get_tasks_model.dart';
import 'package:courses_app/features/home/data/models/get_user_model.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/Failures/Failures.dart';
import '../models/add_course_model.dart';
import '../models/add_task_model.dart';

abstract class HomeRepo {
  Future<Either<Failures, GetCoursesModel>> getCourses({String query = "",String searchCat=""});
  Future<Either<Failures, GetTasksModel>> getTasks({String query = "",String searchCat=""});
  Future<Either<Failures, AddCourseModel>> addCourse({
    required String name,
    required String city,
    required String note,
    required String gender,
    required String phone,
    required String workStatus,
    required String payment,
    required int stateId,
    required int status,
    required int knowUs,
    required int batchNum,
    required int age,
    required String img,
  });
  Future<Either<Failures, EditCourseModel>> editCourse({
    required int courseId,
    String? name,
    String? city,
    String? gender,
    String? phone,
    String? workStatus,
    String? payment,
    int? stateId,
    int? status,
    int? knowUs,
    int? batchNum,
    int? age,
    String? img,
    String? note,
  });
  Future<Either<Failures, AddTaskModel>> addTask({
    required String name,
    required int projectId,
    required int partnerId,
    required int userId,
    required String description,
  });
  Future<Either<Failures, EditTaskModel>> editTask({
    required int taskId,
    String? name,
    int? projectId,
    int? partnerId,
    int? userId,
    String? description,
    String? deadline,
  });
  Future<Either<Failures, GetState>> getState({String query = ""});
  Future<Either<Failures, GetStatus>> getStatus({String query = ""});
  Future<Either<Failures, GetKnowUsModel>> getKnowUs({String query = ""});
  Future<Either<Failures, GetUserModel>> getUsers({String query = ""});
  Future<Either<Failures, GetPartnerModel>> getPartner({String query = ""});
  Future<Either<Failures, GetProjectModel>> getProjects({String query = ""});

  Future<Either<Failures,DeleteCourse>> deleteCourse({required int courseId});
}