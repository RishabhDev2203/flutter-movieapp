import 'dart:developer';
import 'package:dio/dio.dart' hide Headers;
import 'package:dio/dio.dart';
import '../bloc/api_resp_state.dart';
import '../dto/error_dto.dart';

class ServerError implements Exception {
  int? _errorCode;
  String? _errorMessage;

  ServerError.withError({DioError? error}) {
    _handleError(error!);
  }

  int? getErrorCode() {
    return _errorCode;
  }

  String? getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioError error) {
    print(
        "===Path: ${error.requestOptions.baseUrl}${error.requestOptions.path}");
    print("===Params: ${error.requestOptions.queryParameters.toString()}");
    print("===error.type: ${error.type}");
    switch (error.type) {
      case DioErrorType.cancel:
        _errorMessage = "Request was cancelled";
        break;
      case DioErrorType.connectTimeout:
        _errorMessage = "Connection timeout";
        break;
      case DioErrorType.other:
        _errorMessage = "Connection failed due to internet connection";
        break;
      case DioErrorType.receiveTimeout:
        _errorMessage = "Receive timeout in connection";
        break;
      case DioErrorType.response:
        ErrorDto errorDto = ErrorDto.fromJson(error.response?.data);
        if (errorDto != null && errorDto.message != null)
          _errorMessage = errorDto.message;
        else
          _errorMessage = error.response?.statusMessage;
        print("=====errorBody${error.response!.data.toString()}");
        _errorCode = error.response?.statusCode;
        break;
      case DioErrorType.sendTimeout:
        _errorMessage = "Receive timeout in send request";
        break;
    }
    return _errorMessage;
  }

  static ResponseState mapDioErrorToState(DioError dioError) {
    print(">>>>>>>>>>>>>>>>>" + dioError.message);
    print(">>>>>>>>>>>>>>>>>" + dioError.type.toString());
    switch (dioError.type) {
      case DioErrorType.cancel:
        return const ResponseStateError("Request was cancelled");
      case DioErrorType.connectTimeout:
        return const ResponseStateNoInternet("Connection timeout");
      case DioErrorType.receiveTimeout:
        return const ResponseStateNoInternet("Receive timeout in connection");
      case DioErrorType.sendTimeout:
        return const ResponseStateNoInternet("Send timeout in request");
      case DioErrorType.other:
        return const ResponseStateNoInternet(
            "Connection failed due to internet connection");
      case DioErrorType.response:
        try {
          ErrorDto errorDto = ErrorDto.fromJson(dioError.response?.data);
          if (errorDto.message != null) {
            log("=====errorMessage ${errorDto.message}");
            return ResponseStateEmpty(errorDto.message.toString());
          } else {
            log("=====errorCode ${dioError.response?.statusCode}");
            log("=====errorBody ${dioError.response!.data.toString()}");
            return ResponseStateEmpty(dioError.response?.statusMessage ?? "");
          }
        } on Exception catch (e) {
          print("Exception ===== $e");
          return ResponseStateEmpty(dioError.response?.data);
        }
      default:
        return const ResponseStateError("Something went wrong");
    }
  }
}