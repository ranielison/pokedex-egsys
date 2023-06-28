import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pokedex_egsys/core/error/failures.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

class DioClient {
  String baseUrl = "https://pokeapi.co/api/v2";

  String? _auth;
  bool _isUnitTest = false;
  late Dio _dio;

  DioClient({bool isUnitTest = false}) {
    _isUnitTest = isUnitTest;

    //_auth = sl<PrefManager>().token;

    _dio = _createDio();

    //if (!_isUnitTest) _dio.interceptors.add(DioInterceptor());
  }

  Dio get dio {
    if (_isUnitTest) {
      /// Return static dio if is unit test
      return _dio;
    } else {
      /// We need to recreate dio to avoid token issue after login
      //_auth = sl<PrefManager>().token;

      final dio = _createDio();

      //if (!_isUnitTest) dio.interceptors.add(DioInterceptor());

      return dio;
    }
  }

  Dio _createDio() => Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Origin': '',
            if (_auth != null) ...{
              'Authorization': 'Bearer $_auth',
            },
          },
          receiveTimeout: const Duration(seconds: 60),
          connectTimeout: const Duration(seconds: 60),
          validateStatus: (int? status) {
            return status! > 0;
          },
        ),
      );

  Future<Either<Failure, T>> getRequest<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    required ResponseConverter<T> converter,
  }) async {
    try {
      final response = await dio.get(url, queryParameters: queryParameters);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(converter(response.data));
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
      );
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data['description'] as String? ?? e.message,
        ),
      );
    }
  }

  Future<Either<Failure, T>> postRequest<T>(
    String url, {
    Map<String, dynamic>? data,
    required ResponseConverter<T> converter,
  }) async {
    try {
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(converter(response.data));
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
      );
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data['description'] as String? ?? e.message,
        ),
      );
    }
  }

  Future<Either<Failure, T>> putRequest<T>(
    String url, {
    Map<String, dynamic>? data,
    required ResponseConverter<T> converter,
  }) async {
    try {
      final response = await dio.put(url, data: data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(converter(response.data));
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
      );
    } on DioException catch (e) {
      return Left(
        ServerFailure(
          e.response?.data['description'] as String? ?? e.message,
        ),
      );
    }
  }
}
