import 'package:flutter_firebase_ott/network/server_error.dart';

class ApiBaseModel<T> {
  ServerError? _error;
  T? data;
  int? responseCode;

  setException(ServerError error) {
    _error = error;
  }

  setData(T data) {
    this.data = data;
  }

  ServerError? getException() {
    return _error;
  }
}
