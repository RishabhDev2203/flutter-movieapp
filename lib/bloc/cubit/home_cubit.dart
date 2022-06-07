import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_ott/bloc/api_resp_state.dart';
import 'package:flutter_ideal_ott_api/dto/app_content_dto.dart';
import 'package:flutter_ideal_ott_api/dto/category_dto.dart';
import 'package:flutter_ideal_ott_api/dto/continue_watching_dto.dart';
import 'package:flutter_ideal_ott_api/dto/library_dto.dart';
import 'package:flutter_ideal_ott_api/repository/home_repository.dart';

class HomeCubit extends Cubit<ResponseState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(ResponseStateInitial());

  void getBannerMovies({bool enableMock = false}) async {
    emit(ResponseStateLoading());
    List<LibraryDto>? dto;
    try {
      dto = await _homeRepository.getBannerMovies(enableMock: false);
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
      dto = await _homeRepository. getMovieDetails(id,enableMock: false);
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
      dto = await _homeRepository.getFeaturedList(enableMock: false);
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
      dto = await _homeRepository.getSeeAllCategory(id,enableMock: false);
      emit(ResponseStateSuccess(dto));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }

  void getSubCategory(id,{bool enableMock = false}) async {
    emit(ResponseStateLoading());
    List<CategoryDto>? dto;
    try {
      dto = await _homeRepository.getSubCategory(id);
      emit(ResponseStateSuccess(dto));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }

  void getContinueWatching(uid,{bool enableMock = false}) async {
    emit(ResponseStateLoading());
    List<ContinueWatchingDto>? dto;
    try {
      dto = await _homeRepository.getContinueWatching(uid);
      emit(ResponseStateSuccess(dto));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }

  void deleteContinueWatching(id,uid) async {
    emit(ResponseStateLoading());
    try {
      print(">>>>>>>>>>>>>>>>>> : delete");
      await _homeRepository.deleteContinueWatching(id,uid);
      emit(const ResponseStateSuccess(""));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }

  void addVideo(reference,int time,uid,totalLength) async {
    emit(ResponseStateLoading());
    try {
      await _homeRepository.addVideo(reference, time, uid ,totalLength);
      emit(const ResponseStateSuccess(""));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }

  void getSearchList(search) async {
    emit(ResponseStateLoading());
    List<LibraryDto>? dto;
    try {
      dto = await _homeRepository.getSearchList(search);
      emit(ResponseStateSuccess(dto));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }

  void getAppContent(type) async {
    emit(ResponseStateLoading());
    AppContentDto? dto;
    try {
      dto = await _homeRepository.getAppContent(type);
      emit(ResponseStateSuccess(dto));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }

}
