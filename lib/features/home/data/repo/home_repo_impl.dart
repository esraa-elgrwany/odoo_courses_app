import 'package:courses_app/core/Failures/Failures.dart';
import 'package:courses_app/features/home/data/models/add_task_model.dart';
import 'package:courses_app/features/home/data/models/delete_course.dart';
import 'package:courses_app/features/home/data/models/get_courses_model.dart';
import 'package:courses_app/features/home/data/models/get_know_us_model.dart';
import 'package:courses_app/features/home/data/models/get_partner_model.dart';
import 'package:courses_app/features/home/data/models/get_project_model.dart';
import 'package:courses_app/features/home/data/models/get_state.dart';
import 'package:courses_app/features/home/data/models/get_status.dart';
import 'package:courses_app/features/home/data/models/get_tasks_model.dart';
import 'package:courses_app/features/home/data/models/get_user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/api_Services/api-manager.dart';
import '../models/add_course_model.dart';
import 'home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  ApiManager apiManager;

  HomeRepoImpl(this.apiManager);

  @override
  Future<Either<Failures, GetCoursesModel>> getCourses(
      {String query = ""}) async {
    try {
      final Map<String, dynamic> body = {
        "params": {
          "model": "booking.managment",
          "method": "search_read",
          "args": [
            [
              ["name", "ilike", "%$query%"],
            ]
          ],
          "kwargs": {
            "fields": [
              "seq",
              "name",
              "state_id",
              "city",
              "gender",
              "status",
              "phone",
              "booking_responsable",
              "how_know_us",
              "batch_num",
              "age",
              "note",
              "work_status",
              "pay_method",
              "grad_image"
            ]
          }
        }
      };
      Response response = await apiManager.getData(data: body);
      GetCoursesModel model = GetCoursesModel.fromJson(response.data);
      print("get courses++++++++${response.data}");
      if (response.statusCode == 200) {
        return Right(model);
      } else {
        return Left(
            ServerFailure("Unexpected HTTP Error: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(ServerFailure("Exception: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failures, GetTasksModel>> getTasks({String query = ""}) async {
    try {
      final Map<String, dynamic> body = {
        "params": {
          "model": "project.task",
          "method":"get_task_with_users",
          "args": [
            [
            ]
          ],
          "kwargs": {
            "domain": query!= null && query.isNotEmpty
                ? [
              ["name", "=", query]
            ]
                : []
          }
        }
      };
      print("Request Body: $body");  // Log the request body
      Response response = await apiManager.getData(data: body);
      print("task Response: ${response.data}");  // Log the response
      GetTasksModel model = GetTasksModel.fromJson(response.data);
      print("get tasks++++++++${response.data}");
      if (response.statusCode == 200) {
        return Right(model);
      } else {
        return Left(
            ServerFailure("Unexpected HTTP Error: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(ServerFailure("Exception: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failures, AddCourseModel>> addCourse({
    required String name,
    required String city,
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
  }) async {
    try {
      final Map<String, dynamic> body = {
        "params": {
          "model": "booking.managment",
          "method": "create",
          "args": [
            {
              "name": name,
              "state_id": stateId,
              "city": city,
              "gender": gender,
              "status": status,
              "phone": phone,
              "how_know_us": knowUs,
              "batch_num": batchNum,
              "age": age,
              "work_status": workStatus,
              "pay_method": payment,
              "grad_image": img
            }
          ],
          "kwargs": {}
        }
      };
      Response response = await apiManager.getData(data: body);
      AddCourseModel model = AddCourseModel.fromJson(response.data);
      if (response.statusCode == 200) {
        return Right(model);
      } else {
        return Left(
            ServerFailure("Unexpected HTTP Error: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(ServerFailure("Exception: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failures, GetKnowUsModel>> getKnowUs(
      {String query = ""}) async {
    try {
      final Map<String, dynamic> body = {
        "params": {
          "model": "booking.managment.know.us",
          "method": "search_read",
          "args": [
            [
              ["name", "ilike", "%$query%"]
            ]
          ],
          "kwargs": {
            "fields": ["id", "name"]
          }
        }
      };
      Response response = await apiManager.getData(data: body);
      GetKnowUsModel model = GetKnowUsModel.fromJson(response.data);
      if (response.statusCode == 200) {
        return Right(model);
      } else {
        return Left(
            ServerFailure("Unexpected HTTP Error: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(ServerFailure("Exception: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failures, GetPartnerModel>> getPartner(
      {String query = ""}) async {
    try {
      final Map<String, dynamic> body = {
        "params": {
          "model": "res.partner",
          "method": "search_read",
          "args": [
            [
              ["name", "ilike", "%$query%"],
            ]
          ],
          "kwargs": {
            "fields": ["id", "name"]
          }
        }
      };
      Response response = await apiManager.getData(data: body);
      GetPartnerModel model = GetPartnerModel.fromJson(response.data);
      if (response.statusCode == 200) {
        return Right(model);
      } else {
        return Left(
            ServerFailure("Unexpected HTTP Error: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(ServerFailure("Exception: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failures, GetProjectModel>> getProjects(
      {String query = ""}) async {
    try {
      final Map<String, dynamic> body = {
        "params": {
          "model": "project.project",
          "method": "search_read",
          "args": [
            [
              ["name", "ilike", "%$query%"]
            ]
          ],
          "kwargs": {
            "fields": ["id", "name"]
          }
        }
      };
      Response response = await apiManager.getData(data: body);
      GetProjectModel model = GetProjectModel.fromJson(response.data);
      if (response.statusCode == 200) {
        return Right(model);
      } else {
        return Left(
            ServerFailure("Unexpected HTTP Error: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(ServerFailure("Exception: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failures, GetState>> getState({String query = ""}) async {
    try {
      final Map<String, dynamic> body = {
        "params": {
          "model": "res.country.state",
          "method": "search_read",
          "args": [
            [
              ["name", "ilike", "%$query%"],
              ["country_id", "=", 65]
            ]
          ],
          "kwargs": {
            "fields": ["id", "name"]
          }
        }
      };
      Response response = await apiManager.getData(data: body);
      GetState model = GetState.fromJson(response.data);
      if (response.statusCode == 200) {
        return Right(model);
      } else {
        return Left(
            ServerFailure("Unexpected HTTP Error: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(ServerFailure("Exception: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failures, GetStatus>> getStatus({String query = ""}) async {
    try {
      final Map<String, dynamic> body = {
        "params": {
          "model": "booking.managment.status",
          "method": "search_read",
          "args": [
            [
              ["name", "ilike", "%$query%"],
            ]
          ],
          "kwargs": {
            "fields": ["id", "name"]
          }
        }
      };
      Response response = await apiManager.getData(data: body);
      GetStatus model = GetStatus.fromJson(response.data);
      if (response.statusCode == 200) {
        return Right(model);
      } else {
        return Left(
            ServerFailure("Unexpected HTTP Error: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(ServerFailure("Exception: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failures, GetUserModel>> getUsers({String query = ""}) async {
    try {
      final Map<String, dynamic> body = {
        "params": {
          "model": "res.users",
          "method": "search_read",
          "args": [
            [
              ["name", "ilike", "%$query%"],
            ]
          ],
          "kwargs": {
            "fields": ["id", "name"]
          }
        }
      };
      Response response = await apiManager.getData(data: body);
      GetUserModel model = GetUserModel.fromJson(response.data);
      if (response.statusCode == 200) {
        return Right(model);
      } else {
        return Left(
            ServerFailure("Unexpected HTTP Error: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(ServerFailure("Exception: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failures, AddTaskModel>> addTask(
      {required String name,
      required int projectId,
      required int partnerId,
      required int userId,
      required String description}) async {
    try {
      final Map<String, dynamic> body = {
        "params": {
          "model": "project.task",
          "method": "create",
          "args": [
            {
              "name": name,
              "project_id": projectId,
              "partner_id": partnerId,
              "user_ids": [userId],
              "description": description
            }
          ],
          "kwargs": {}
        }
      };
      Response response = await apiManager.getData(data: body);
      AddTaskModel model = AddTaskModel.fromJson(response.data);
      if (response.statusCode == 200) {
        return Right(model);
      } else {
        return Left(
            ServerFailure("Unexpected HTTP Error: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(ServerFailure("Exception: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failures, DeleteCourse>> deleteCourse(
      {required int courseId}) async {
    try {
      final Map<String, dynamic> body = {
        "params": {
          "model": "booking.managment",
          "method": "unlink",
          "args": [courseId],
          "kwargs": {}
        }
      };
      Response response = await apiManager.deleteData(body: body);
      DeleteCourse model = DeleteCourse.fromJson(response.data);
      if (response.statusCode == 200) {
        return Right(model);
      } else {
        return Left(
            ServerFailure("Unexpected HTTP Error: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(ServerFailure("Exception: ${e.toString()}"));
    }
  }
}
