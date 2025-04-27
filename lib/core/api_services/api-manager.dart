import 'package:dio/dio.dart';
import '../cache/shared_preferences.dart';
import 'Constants.dart';

class ApiManager {
  Dio dio = Dio();
 String session= CacheData.getData(key: "sessionId")??"";
  Future<Response> getData({Map<String, dynamic>? data}) async {
    print("session+++++++++$session");
    return await dio.get(
      Constants.baseUrl,
      data: data,
      options:Options(
    headers: {
    'Content-Type': "application/json",
    "User-Agent": "insomnia/10.3.0",
    "Cookie":'session_id=$session',
    },
    ),
    );
  }

  postData({Map<String, dynamic>? body}) async {
    print("session+++++++++$session");
    return await dio.post(
      Constants.baseUrl,
      data: body,
     options: Options(
    headers: {
    'Content-Type': "application/json",
    "User-Agent": "insomnia/10.3.0",
    "Cookie":'session_id=$session',
    },
    ),
    );
  }
  deleteData({Map<String, dynamic>? body}) async {
    return await dio.delete(
      Constants.baseUrl,
      data: body,
      options: Options(
        headers: {
          'Content-Type': "application/json",
          "User-Agent": "insomnia/10.3.0",
          "Cookie":'session_id=$session',
        },
      ),
    );
  }
}
