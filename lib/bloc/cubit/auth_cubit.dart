
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_ott/dto/user_dto.dart';
import '../../network/server_error.dart';
import '../../repository/auth_repository.dart';
import '../api_resp_state.dart';

class AuthCubit extends Cubit<ResponseState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(ResponseStateInitial());

  void createAccount(name, email, password) async {
    emit(ResponseStateLoading());
    UserDto dto;
    try {
      dto = (await _authRepository.createAccount(name, email, password))!;
      if(dto.message != null && dto.message!.isNotEmpty) {
        emit(ResponseStateError(dto.message ?? ""));
      } else {
        emit(ResponseStateSuccess(dto));
      }

    }
    on DioError catch (error) {
      emit(ServerError.mapDioErrorToState(error));
    }
  }
}
