import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/Failures/Failures.dart';
import '../../../../core/api_services/api-manager.dart';
import '../../data/Repo/auth_repo.dart';
import '../../data/Repo/auth_repo_impl.dart';
import '../../data/models/login_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  static LoginCubit get(context) => BlocProvider.of(context);

  LoginCubit() : super(LoginInitial());

  Future<void> login(String username, String password) async {
    emit(LoginLoading());
    ApiManager apiManager = ApiManager();
    AuthRepo authRepo = AuthRepoImpl(apiManager);
    final response = await authRepo.login(username, password);
    response.fold(
      (failure) => emit(LoginFailure(failure)),
      (loginModel) => emit(LoginSuccess(loginModel)),
    );
  }

}
