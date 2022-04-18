
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retrofit/retrofit.dart';

import '../../dto/utility_dto.dart';
import '../../network/server_error.dart';
import '../../repository/auth_repository.dart';
import '../api_resp_state.dart';

class AuthCubit extends Cubit<ResponseState> {
  final AuthRepository yogaRepository;

  AuthCubit(this.yogaRepository) : super(ResponseStateInitial());

  void apiyogaVideoList() async {
    emit(ResponseStateLoading());
    HttpResponse httpResponse;
    UtilityDto dto;
    try {
      httpResponse = await yogaRepository.apiyogaVideoList();
      dto = httpResponse.data as UtilityDto;
      emit(ResponseStateSuccess(dto));
    }
    on DioError catch (error) {
      emit(ServerError.mapDioErrorToState(error));
    }
  }
}
