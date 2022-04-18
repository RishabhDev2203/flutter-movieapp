import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dto/utility_dto.dart';
import '../network/logging_interceptor.dart';
import '../network/rest_client.dart';
import '../util/app_session.dart';

class AuthRepository {
  final Dio _dio = Dio();
  late RestClient _apiClient;
  AppSession? appSession;
  String token = "";

  AuthRepository() {
    _dio.interceptors.add(LoggingInterceptor());
    _apiClient = RestClient(_dio);
    appSession = AppSession();
  }

  Future<HttpResponse<UtilityDto>> apiyogaVideoList() async {
    return _apiClient.apiyogaVideoList();
  }

}