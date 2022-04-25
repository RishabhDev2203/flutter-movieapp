
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_ott/dto/user_dto.dart';
import '../../repository/auth_repository.dart';
import '../../util/app_session.dart';
import '../api_resp_state.dart';

class AuthCubit extends Cubit<ResponseState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(ResponseStateInitial());

  void createAccount(name, email, password) async {
    emit(ResponseStateLoading());
    UserDto dto;
    try {
      dto = (await _authRepository.createAccount(name, email, password))!;
      AppSession().storeUserDetail(dto.toJson());
      emit(ResponseStateSuccess(dto));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }
  void loginAccount(email, password) async {
    emit(ResponseStateLoading());
    UserDto dto;
    try {
      dto = (await _authRepository.loginAccount(email, password))!;
      AppSession().storeUserDetail(dto.toJson());
      emit(ResponseStateSuccess(dto));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }

  void logoutAccount() async {
    emit(ResponseStateLoading());
    try {
      (await _authRepository.logoutAccount());
      emit(ResponseStateSuccess(""));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }

  void changePassword(String currentPassword ,String newPassword) async {
    emit(ResponseStateLoading());
    try {
      (await _authRepository.changePassword(currentPassword,newPassword));
      emit(ResponseStateSuccess(""));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }

  void apiGoogleLogin(String email,String name) async {
    emit(ResponseStateLoading());
    UserDto dto;
    try {
      dto = (await _authRepository.apiGoogleLogin(email,name))!;
      AppSession().storeUserDetail(dto.toJson());
      emit(ResponseStateSuccess(dto));

    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }


  void forgotPassword(email) async {
    emit(ResponseStateLoading());
    try {
      await _authRepository.forgotPassword(email);
      emit(ResponseStateSuccess(""));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }

  void update(context,data) async {
    emit(ResponseStateLoading());
    UserDto dto;
    try {
      dto = (await _authRepository.update(context,data));
      AppSession().storeUserDetail(dto.toJson());
      emit(ResponseStateSuccess(dto));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }
}
