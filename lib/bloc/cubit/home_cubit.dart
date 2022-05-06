import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ideal_ott_api/dto/category_dto.dart';
import 'package:flutter_ideal_ott_api/dto/library_dto.dart';
import 'package:flutter_ideal_ott_api/repository/home_repository.dart';
import '../api_resp_state.dart';

class HomeCubit extends Cubit<ResponseState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(ResponseStateInitial());

  void getBannerMovies() async {
    emit(ResponseStateLoading());
    List<LibraryDto?>? dto;
    try {
      dto = await _homeRepository.getBannerMovies(enableMock:true);
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
      dto = await _homeRepository. getMovieDetails(id,enableMock:true);
      emit(ResponseStateSuccess(dto));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }

  void getMovieCategory() async {
    emit(ResponseStateLoading());
    List<CategoryDto?>? dto;
    try {
      dto = await _homeRepository.getMovieCategory(enableMock:true);
      print("dto>>>>>>>>>>>> ${dto?[0]?.avatar}");
      emit(ResponseStateSuccess(dto));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }

}
