import '../../../../core/Failures/Failures.dart';
import 'package:dartz/dartz.dart';
import '../models/login_model.dart';

abstract class AuthRepo {
  Future<Either<Failures, LoginModel>> login(String userName, String password);

}
