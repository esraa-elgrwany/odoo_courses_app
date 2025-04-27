import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/api_Services/api-manager.dart';
import '../../../../core/Failures/Failures.dart';
import '../../../../core/cache/shared_preferences.dart';
import '../models/login_model.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  ApiManager apiManager;

  AuthRepoImpl(this.apiManager);

  @override
  Future<Either<Failures, LoginModel>> login(
      String user, String password) async {
    final Map<String, dynamic> body = {
      "params":{
        "login":user,
        "password":password,
        "db":"odoo"
      }
    };

    try {
      Dio dio = Dio();
      final response = await dio.post(
        "https://zanaty.top/web/session/authenticate",
        data: body,
        options: Options(
          headers: {
            'Content-Type': "application/json",
            "User-Agent": "insomnia/10.3.0",
          },
        ),
      );
      LoginModel user = LoginModel.fromJson(response.data);
      CacheData.saveId(data: user.result?.uid, key: "userId");
      final rawCookie = response.headers.map['set-cookie']?.first;
      final sessionId = rawCookie
          ?.split(';')
          .firstWhere((e) => e.contains("session_id="))
          .split("=")[1];

      print("Session ID: $sessionId");
      CacheData.saveId(data: sessionId, key: "sessionId");
      if (response.statusCode == 200) {
        return Right(user);
      } else {
        return Left(
            ServerFailure("Unexpected HTTP Error: ${response.statusCode}"));
      }
    } catch (e) {
      return Left(ServerFailure("Network Error: $e"));
    }
  }

}
