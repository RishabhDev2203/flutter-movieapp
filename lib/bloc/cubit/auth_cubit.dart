import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_ott/dto/user_dto.dart';
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
      emit(ResponseStateSuccess(dto));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }
}
