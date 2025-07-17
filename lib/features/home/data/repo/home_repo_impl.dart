import 'package:courses_app/core/Failures/Failures.dart';
import 'package:courses_app/features/home/data/models/add_task_model.dart';
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
import 'package:dio/dio.dart';
import '../../../../core/api_services/api-manager.dart';
import '../models/add_course_model.dart';
import 'home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  ApiManager apiManager;

  HomeRepoImpl(this.apiManager);

  @override
  Future<Either<Failures, GetCoursesModel>> getCourses(
      {String query = "",String searchCat="name"}) async {
    try {
      final Map<String, dynamic> body = {
        "params": {
          "model": "booking.managment",
          "method": "search_read",
          "args": [
      query!= null && query.isNotEmpty?
      [[searchCat, "ilike", "%$query%"]]:[]
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
              "create_date",
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
  Future<Either<Failures, GetTasksModel>> getTasks({String query = "",String searchCat=""}) async {
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
              [searchCat, "ilike", "%$query%"]
            ]
                : []
          }
        }
      };
      print("Request Body: $body");
      Response response = await apiManager.getData(data: body);
      print("task Response: ${response.data}");
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
              "note":note,
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

  @override
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
  }) async {
    try {
      final Map<String, dynamic> fieldsToUpdate = {};
      if (name != null) fieldsToUpdate["name"] = name;
      if (stateId != null) fieldsToUpdate["state_id"] = stateId;
      if (city != null) fieldsToUpdate["city"] = city;
      if (gender != null) fieldsToUpdate["gender"] = gender;
      if (status != null) fieldsToUpdate["status"] = status;
      if (phone != null) fieldsToUpdate["phone"] = phone;
      if (knowUs != null) fieldsToUpdate["how_know_us"] = knowUs;
      if (batchNum != null) fieldsToUpdate["batch_num"] = batchNum;
      if (age != null) fieldsToUpdate["age"] = age;
      if (workStatus != null) fieldsToUpdate["work_status"] = workStatus;
      if (payment != null) fieldsToUpdate["pay_method"] = payment;
      if (img != null) fieldsToUpdate["grad_image"] = img;
      if (note != null) fieldsToUpdate["note"] = note;

      final Map<String, dynamic> body = {
        "params": {
          "model": "booking.managment",
          "method": "write",
          "args": [
            [courseId],
            fieldsToUpdate,
          ],
          "kwargs": {}
        }
      };

      Response response = await apiManager.postData(body: body); // <-- use POST

      if (response.statusCode == 200) {
        EditCourseModel model = EditCourseModel.fromJson(response.data);
        return Right(model);
      } else {
        return Left(ServerFailure("Unexpected HTTP Error: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(ServerFailure("Exception: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failures, EditTaskModel>> editTask({
    required int taskId,
    String? name,
    int? projectId,
    int? partnerId,
    int? userId,
    String? description,
    String? deadline,
  }) async {
    try {
      final Map<String, dynamic> fieldsToUpdate = {};

      if (name != null) fieldsToUpdate["name"] = name;
      if (projectId != null) fieldsToUpdate["project_id"] = projectId;
      if (partnerId != null) fieldsToUpdate["partner_id"] = partnerId;
      if (description != null) fieldsToUpdate["description"] = description;
      if (deadline != null) fieldsToUpdate["date_deadline"] = deadline;
      if (userId != null) {
        fieldsToUpdate["user_ids"] = [
          [6, 0, [userId]]
        ];
      }

      final Map<String, dynamic> body = {
        "params": {
          "model": "project.task",
          "method": "write",
          "args": [
            [taskId],
            fieldsToUpdate,
          ],
          "kwargs": {}
        }
      };

      Response response = await apiManager.postData(body: body);

      if (response.statusCode == 200) {
        EditTaskModel model = EditTaskModel.fromJson(response.data);
        return Right(model);
      } else {
        return Left(ServerFailure("Unexpected HTTP Error: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(ServerFailure("Exception: ${e.toString()}"));
    }
  }

}
