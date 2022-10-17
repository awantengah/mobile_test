import 'dart:convert';
import 'package:dio/dio.dart';

class Repository {
  final Dio dio = Dio()..interceptors.add(Logging());

  getResponse(String url) async {
    try {
      var response = await dio.get(
        url,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      dynamic data;
      if (response.data.runtimeType == String) {
        data = jsonDecode(response.data);
      } else {
        data = response.data;
      }
      return data;
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
      return null;
    }
  }
}

class Logging extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // ignore: avoid_print
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // ignore: avoid_print
    print(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // ignore: avoid_print
    print(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    return super.onError(err, handler);
  }
}
