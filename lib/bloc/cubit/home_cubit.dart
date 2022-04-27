import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_ott/dto/category_dto.dart';
import 'package:flutter_firebase_ott/dto/content_dto.dart';
import 'package:flutter_firebase_ott/dto/library_dto.dart';
import 'package:flutter_firebase_ott/repository/home_repository.dart';
import '../api_resp_state.dart';

class HomeCubit extends Cubit<ResponseState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(ResponseStateInitial());

  void getBannerMovies({bool enableMock = false}) async {
    emit(ResponseStateLoading());
    List<LibraryDto?>? dto;
    try {
      dto = await _homeRepository.getBannerMovies();
      emit(ResponseStateSuccess(dto));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }

  void getMoviesDetail(id,{bool enableMock = false}) async {
    emit(ResponseStateLoading());
    LibraryDto? dto;
    try {
      dto = await _homeRepository. getMovieDetails(id);
      emit(ResponseStateSuccess(dto));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }

  void getMovieCategory({bool enableMock = false}) async {
    emit(ResponseStateLoading());
    List<CategoryDto?>? dto;
    try {
      dto = await _homeRepository.getMovieCategory();
      print("dto>>>>>>>>>>>> ${dto?[0]?.avatar}");
      emit(ResponseStateSuccess(dto));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }

}
