import 'package:dio/dio.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart';
import '../dto/utility_dto.dart';
part 'rest_client.g.dart';

@RestApi(baseUrl: "https://d4layzaz9ldrt.cloudfront.net")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  static const header = [
    "Accept: application/json",
    "Content-Type: application/x-www-form-urlencoded"
  ];
  static const HEADER_VALUE = "Accept: application/json";
  static const HEADER_CONTENT_TYPE =
      "Content-Type: application/x-www-form-urlencoded";

  static const AUTHORIZATION = "Authorization";

  @GET("/yoga.json")
  @Header(HEADER_VALUE)
  Future<HttpResponse<UtilityDto>> apiyogaVideoList();



}
