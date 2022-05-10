import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_ott/bloc/api_resp_state.dart';
import 'package:flutter_ideal_ott_api/dto/category_dto.dart';
import 'package:flutter_ideal_ott_api/dto/library_dto.dart';
import 'package:flutter_ideal_ott_api/repository/home_repository.dart';

class HomeCubit extends Cubit<ResponseState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(ResponseStateInitial());

  void getBannerMovies({bool enableMock = false}) async {
    emit(ResponseStateLoading());
    List<LibraryDto>? dto;
    try {
      dto = await _homeRepository.getBannerMovies(enableMock: true);
      emit(ResponseStateSuccess(dto));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }

  void getMoviesDetail(id) async {
    emit(ResponseStateLoading());
    LibraryDto? dto;
    try {
      dto = await _homeRepository. getMovieDetails(id,enableMock: true);
      emit(ResponseStateSuccess(dto));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }

  void getFeaturedList() async {
    emit(ResponseStateLoading());
    List<CategoryDto>? dto;
    try {
      dto = await _homeRepository.getFeaturedList(enableMock: true);
      emit(ResponseStateSuccess(dto));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }

  void getSeeAllCategory(id) async {
    emit(ResponseStateLoading());
    CategoryDto? dto;
    try {
      dto = await _homeRepository.getSeeAllCategory(id,enableMock: true);
      emit(ResponseStateSuccess(dto));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }

}
