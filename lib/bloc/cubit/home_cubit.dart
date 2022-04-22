import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      print("dto>>>>>>>>>>>>>>>>>>>>>>> ${dto?[0]?.slug ?? ""}");
      print("dto.length>>>>>>>>>>>>>>>>>>>>>>> ${dto?.length}");
      print("dto>>>>>>>>>>>>>>>>>>>>>>> ${dto?[0]?.type?[0] ?? ""}");
      print("dto>>>>>>>>>>>>>>>>>>>>>>> ${dto?[0]?.thumbnails?[0].url}");
      emit(ResponseStateSuccess(dto));
    }
    on FirebaseException catch (error) {
      emit(ResponseStateError(error.message?? ""));
    }
  }

}
