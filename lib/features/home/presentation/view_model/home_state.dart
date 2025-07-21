part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class GetCoursesLoading extends HomeState {}

class GetCoursesSuccess extends HomeState {
  GetCoursesModel model;

  GetCoursesSuccess(this.model);
}

class GetCoursesError extends HomeState {
  Failures failures;

  GetCoursesError(this.failures);
}

class GetTasksLoading extends HomeState {}

class GetTasksSuccess extends HomeState {
  GetTasksModel model;

  GetTasksSuccess(this.model);
}

class GetTasksError extends HomeState {
  Failures failures;

  GetTasksError(this.failures);
}
//get state
class GetStateLoading extends HomeState {}

class GetStateSuccess extends HomeState {
  GetState model;

  GetStateSuccess(this.model);
}

class GetStateError extends HomeState {
  Failures failures;

  GetStateError(this.failures);
}
//get status
class GetStatusLoading extends HomeState {}

class GetStatusSuccess extends HomeState {
  GetStatus model;

  GetStatusSuccess(this.model);
}

class GetStatusError extends HomeState {
  Failures failures;

  GetStatusError(this.failures);
}

//get know us
class GetKnowUsLoading extends HomeState {}

class GetKnowUsSuccess extends HomeState {
  GetKnowUsModel model;

  GetKnowUsSuccess(this.model);
}

class GetKnowUsError extends HomeState {
  Failures failures;

  GetKnowUsError(this.failures);
}

//get partner
class GetPartnerLoading extends HomeState {}

class GetPartnerSuccess extends HomeState {
  GetPartnerModel model;

  GetPartnerSuccess(this.model);
}

class GetPartnerError extends HomeState {
  Failures failures;

  GetPartnerError(this.failures);
}

//get project
class GetProjectLoading extends HomeState {}

class GetProjectSuccess extends HomeState {
  GetProjectModel model;

  GetProjectSuccess(this.model);
}

class GetProjectError extends HomeState {
  Failures failures;

  GetProjectError(this.failures);
}

//get user
class GetUserLoading extends HomeState {}

class GetUserSuccess extends HomeState {
  GetUserModel model;

  GetUserSuccess(this.model);
}

class GetUserError extends HomeState {
  Failures failures;

  GetUserError(this.failures);
}

//add task
class AddTaskLoading extends HomeState {}

class AddTaskSuccess extends HomeState {
  AddTaskModel model;

  AddTaskSuccess(this.model);
}

class AddTaskError extends HomeState {
  Failures failures;

  AddTaskError(this.failures);
}

class AddCourseLoading extends HomeState {}

class AddCourseSuccess extends HomeState {
  AddCourseModel model;

  AddCourseSuccess(this.model);
}

class AddCourseError extends HomeState {
  Failures failures;

  AddCourseError(this.failures);
}

class DeleteCoursesLoading extends HomeState {}

class DeleteCoursesSuccess extends HomeState {
  DeleteCourse model;

  DeleteCoursesSuccess(this.model);
}

class DeleteCoursesError extends HomeState {
  Failures failures;

  DeleteCoursesError(this.failures);
}
class EditCoursesLoading extends HomeState {}

class EditCoursesSuccess extends HomeState {
   EditCourseModel model;
  EditCoursesSuccess(this.model);
}

class EditCoursesError extends HomeState {
  final Failures failure;
  EditCoursesError(this.failure);
}


class EditTaskLoading extends HomeState {}

class EditTaskSuccess extends HomeState {
  final EditTaskModel task;
  EditTaskSuccess(this.task);
}

class EditTaskError extends HomeState {
  final Failures failure;
  EditTaskError(this.failure);
}

class GetEditUserLoading extends HomeState {}

class GetEditUserSuccess extends HomeState {
  EditUserModel model;

  GetEditUserSuccess(this.model);
}

class GetEditUserError extends HomeState {
  Failures failures;

  GetEditUserError(this.failures);
}