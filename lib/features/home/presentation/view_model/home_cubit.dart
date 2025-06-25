import 'package:bloc/bloc.dart';
import 'package:courses_app/features/home/data/models/add_course_model.dart';
import 'package:courses_app/features/home/data/models/edit_course_model.dart';
import 'package:courses_app/features/home/data/models/get_know_us_model.dart';
import 'package:courses_app/features/home/data/models/get_partner_model.dart';
import 'package:courses_app/features/home/data/models/get_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/api_Services/api-manager.dart';
import '../../../../core/Failures/Failures.dart';
import '../../data/models/add_task_model.dart';
import '../../data/models/delete_course.dart';
import '../../data/models/get_courses_model.dart';
import '../../data/models/get_project_model.dart';
import '../../data/models/get_state.dart';
import '../../data/models/get_tasks_model.dart';
import '../../data/models/get_user_model.dart';
import '../../data/repo/home_repo.dart';
import '../../data/repo/home_repo_impl.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  static HomeCubit get(context) => BlocProvider.of(context);

  List<CoursesResult> courses = [];
  List<PartnerResult> partners = [];
  List<ProjectResult> projects = [];
  List<UserResult> users = [];
  List<StateResult> states = [];
  List<StatusResult> status = [];
  List<KnowUsResult> knowUs = [];
  List<TaskResult> tasks = [];

  HomeCubit() : super(HomeInitial());

  getCourses({String query = ""}) async {
    emit(GetCoursesLoading());
    ApiManager apiManager = ApiManager();
    HomeRepo homeRepo = HomeRepoImpl(apiManager);
    var result = await homeRepo.getCourses(query: query);
    result.fold((l) {
      emit(GetCoursesError(l));
    }, (r) {
      courses = r.result ?? [];
      emit(GetCoursesSuccess(r));
    });
  }

  getTasks({String query = ""}) async {
    emit(GetTasksLoading());
    ApiManager apiManager = ApiManager();
    HomeRepo homeRepo = HomeRepoImpl(apiManager);
    var result = await homeRepo.getTasks(query: query);
    result.fold((l) {
      emit(GetTasksError(l));
    }, (r) {
      tasks = r.result ?? [];
      emit(GetTasksSuccess(r));
    });
  }

  getUsers({String query = ""}) async {
    emit(GetUserLoading());
    ApiManager apiManager = ApiManager();
    HomeRepo homeRepo = HomeRepoImpl(apiManager);
    var result = await homeRepo.getUsers(query: query);
    result.fold((l) {
      emit(GetUserError(l));
    }, (r) {
      users = r.result ?? [];
      emit(GetUserSuccess(r));
    });
  }

  getProjects({String query = ""}) async {
    emit(GetProjectLoading());
    ApiManager apiManager = ApiManager();
    HomeRepo homeRepo = HomeRepoImpl(apiManager);
    var result = await homeRepo.getProjects(query: query);
    result.fold((l) {
      emit(GetProjectError(l));
    }, (r) {
      projects = r.result ?? [];
      emit(GetProjectSuccess(r));
    });
  }

  getPartners({String query = ""}) async {
    emit(GetPartnerLoading());
    ApiManager apiManager = ApiManager();
    HomeRepo homeRepo = HomeRepoImpl(apiManager);
    var result = await homeRepo.getPartner(query: query);
    result.fold((l) {
      emit(GetPartnerError(l));
    }, (r) {
      partners = r.result ?? [];
      emit(GetPartnerSuccess(r));
    });
  }

  getStates({String query = ""}) async {
    emit(GetStateLoading());
    ApiManager apiManager = ApiManager();
    HomeRepo homeRepo = HomeRepoImpl(apiManager);
    var result = await homeRepo.getState(query: query);
    result.fold((l) {
      emit(GetStateError(l));
    }, (r) {
      states = r.result ?? [];
      emit(GetStateSuccess(r));
    });
  }

  getStatus({String query = ""}) async {
    emit(GetStatusLoading());
    ApiManager apiManager = ApiManager();
    HomeRepo homeRepo = HomeRepoImpl(apiManager);
    var result = await homeRepo.getStatus(query: query);
    result.fold((l) {
      emit(GetCoursesError(l));
    }, (r) {
      status = r.result ?? [];
      emit(GetStatusSuccess(r));
    });
  }

  getKnowUs({String query = ""}) async {
    emit(GetKnowUsLoading());
    ApiManager apiManager = ApiManager();
    HomeRepo homeRepo = HomeRepoImpl(apiManager);
    var result = await homeRepo.getKnowUs(query: query);
    result.fold((l) {
      emit(GetKnowUsError(l));
    }, (r) {
      knowUs = r.result ?? [];
      emit(GetKnowUsSuccess(r));
    });
  }

  addTask({
    required String name,
    required int projectId,
    required int partnerId,
    required int userId,
    required String description,
  }) async {
    emit(AddTaskLoading());
    ApiManager apiManager = ApiManager();
    HomeRepo homeRepo = HomeRepoImpl(apiManager);
    var result = await homeRepo.addTask(
        name: name,
        projectId: projectId,
        partnerId: partnerId,
        userId: userId,
        description: description);
    result.fold((l) {
      emit(AddTaskError(l));
    }, (r) {
      emit(AddTaskSuccess(r));
    });
  }

  addCourse({
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
    emit(AddCourseLoading());
    ApiManager apiManager = ApiManager();
    HomeRepo homeRepo = HomeRepoImpl(apiManager);
    var result = await homeRepo.addCourse(
        name: name,
        city: city,
        gender: gender,
        phone: phone,
        workStatus: workStatus,
        payment: payment,
        stateId: stateId,
        status: status,
        knowUs: knowUs,
        batchNum: batchNum,
        age: age,
        img: img);
    result.fold((l) {
      emit(AddCourseError(l));
    }, (r) {
      emit(AddCourseSuccess(r));
    });
  }

  deleteCourse({required int courseId}) async {
    emit(DeleteCoursesLoading());
    ApiManager apiManager = ApiManager();
    HomeRepo homeRepo = HomeRepoImpl(apiManager);
    var result = await homeRepo.deleteCourse(courseId: courseId);
    result.fold((l) {
      emit(DeleteCoursesError(l));
    }, (r) {
      courses.removeWhere((course) => course.id == courseId);
      print(courses.length);
      emit(DeleteCoursesSuccess(r));
      getCourses();
    });
  }

  void editCourse({
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
    emit(EditCoursesLoading());

      final ApiManager apiManager = ApiManager();
      final HomeRepo homeRepo = HomeRepoImpl(apiManager);

      final result = await homeRepo.editCourse(
        courseId: courseId,
        name: name,
        city: city,
        gender: gender,
        phone: phone,
        workStatus: workStatus,
        payment: payment,
        stateId: stateId,
        status: status,
        knowUs: knowUs,
        batchNum: batchNum,
        age: age,
        img: img,
        note: note,
      );

      result.fold(
        (failure) => emit(EditCoursesError(failure)),
        (model) {
          emit(EditCoursesSuccess(model));
          getCourses(); // Refresh list after editing
        },
      );
  }
}
