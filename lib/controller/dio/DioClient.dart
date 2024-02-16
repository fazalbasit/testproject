import 'dart:io';
import 'package:dio/dio.dart';
import 'logging_interceptor.dart';

class DioClient {
  static final DioClient _singleton = DioClient._internal();
  late final Dio dio;
  String baseUrl;
  String token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjMGYyNmFjYzhjMDlmYWNjZjc1NTAxMTI4OTZlY2ZlYiIsInN1YiI6IjY1YzhlOWFkMjY2Nzc4MDE3YzU5M2NlYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.KaZF5P8GNjXJYoCAFIOqXu8ZVhix9PpYDxVSYW0ph3U";

  factory DioClient(String baseUrl) {
    _singleton.baseUrl = baseUrl;
    return _singleton;
  }

  DioClient._internal() : baseUrl = 'https://api.themoviedb.org/3/' {
    LoggingInterceptor loggingInterceptor = LoggingInterceptor();
    dio = Dio(BaseOptions(
      responseType: ResponseType.plain,
      baseUrl: baseUrl,
      connectTimeout: 50000,
      receiveTimeout: 50000,
      validateStatus: (status) {
        return status! < 500;
      },
      headers: {'Accept': 'application/json'},
      contentType: 'application/json',
    ));
    dio.interceptors.add(loggingInterceptor);
  }

  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.get(
        uri,
        queryParameters: {'api_key': 'c0f26acc8c09faccf7550112896ecfeb'},
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      print(response);
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<Response> postData(
    String uri,
    String token,
    String body, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.post(
        uri,
        data: body,
        queryParameters: queryParameters,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          contentType: 'application/json',
          receiveTimeout: 50000,
          sendTimeout: 50000,
        ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<Response> post(String uri,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress,
      String? token}) async {
    try {
      var response = await dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<Response> patch(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.patch(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<Response> put(
    String uri,
    String token,
    String body, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      var response = await dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          contentType: 'application/json',
          receiveTimeout: 50000,
          sendTimeout: 50000,
        ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  Future<Response> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      var response = await dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }
}
