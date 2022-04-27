import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_ott/dto/category_dto.dart';
import 'package:flutter_firebase_ott/dto/content_dto.dart';
import 'package:flutter_firebase_ott/dto/library_dto.dart'as lib;

class HomeRepository {

  Future<List<lib.LibraryDto?>?> getBannerMovies({bool enableMock = false}) async {
    var list;

    if(enableMock == true){
      return list;
    }

    try {
      CollectionReference collRef =
      FirebaseFirestore.instance.collection('library');
      final querySnapshot = await collRef
          .where('isFeatures', isEqualTo: true)
          .where('status', isEqualTo: "published")
          .where('deletedAt', isEqualTo: null)
          // .where('deletedAt', arrayContainsAny: ["null"],isLessThan: DateTime.now().toUtc())
          // .where('publishedAt', isLessThan: DateTime.now().toUtc())
          .limit(10)
          .withConverter<lib.LibraryDto>(
          fromFirestore: (snapshot, _) {
            return lib.LibraryDto.fromJson(
                snapshot.data()!);
          },
          toFirestore: (model, _) => model.toJson())
          .get();

      list = querySnapshot.docs.map((d)  async {
        var e = lib.LibraryDto.fromJson(d.data().toJson());
         var v = await getContent(e.content);
         e.id = d.reference.id;
         e.videoContent?.outputUrl = v?.outputUrl;
         e.videoContent = ContentDto(
             outputUrl:  v?.outputUrl,
             createdAt: v?.createdAt,
             duration: v?.duration,
             sourceUrl: v?.outputUrl,
             extension: v?.extension,
             status: v?.status,
         );
        print("id>>>>>>>>>>>>>>>>>>>>>${e.id }");
        return e;
      });

      return Future.wait(list);
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  Future<lib.LibraryDto?> getMovieDetails(id,{bool enableMock = false}) async {
    lib.LibraryDto? dto;

    if(enableMock == true){
      return dto;
    }

    try {
      var collRef =
      FirebaseFirestore.instance.collection('library').doc(id);
      final querySnapshot = await collRef
          // .where('isFeatures', isEqualTo: true)
          // .where('status', isEqualTo: "published")
          // .where('deletedAt', isEqualTo: null)
      // .where('deletedAt', arrayContainsAny: ["null"],isLessThan: DateTime.now().toUtc())
      // .where('publishedAt', isLessThan: DateTime.now().toUtc())
         // .limit(10)
          .withConverter<lib.LibraryDto>(
          fromFirestore: (snapshot, _) {
            return lib.LibraryDto.fromJson(
                snapshot.data()!);
          },
          toFirestore: (model, _) => model.toJson())
          .get();

      if(querySnapshot.data() != null){
        dto = querySnapshot.data();
        var v = await getContent(querySnapshot.data()?.content);
        dto?.videoContent = v;
      }
      return dto;
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  Future<List<CategoryDto?>?> getMovieCategory({bool enableMock = false}) async {
    var list;

    if(enableMock == true){
      return list;
    }

    try {

      var querySnapshot = await FirebaseFirestore.instance.collection('category')
          .withConverter<CategoryDto>(
          fromFirestore: (snapshot, _) {
            return CategoryDto.fromJson(
                snapshot.data()!);
          },
          toFirestore: (model, _) => model.toJson())
          .get();

      list = querySnapshot.docs.map((d) async{
        var e = CategoryDto.fromJson(d.data().toJson());
        e.library

        print(">>>>>>>>>>>>>>>>>>>>>>1 ${e.avatar}");
        return e;
      });

      return Future.wait(list);
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  Future<ContentDto?> getContent(DocumentReference? doc) async {
    CollectionReference collRef =
    FirebaseFirestore.instance.collection("content");
    final docSnapshot = await collRef
        .doc(doc?.id)
        .withConverter<ContentDto>(
        fromFirestore: (snapshot, _) =>
            ContentDto.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson())
        .get();
    return docSnapshot.data();
  }

  Future<lib.LibraryDto?> getLibCategory(DocumentReference? doc,{bool enableMock = false}) async {
    try {
      CollectionReference collRef =
      FirebaseFirestore.instance.collection('library');
      final docSnapshot = await collRef
          .doc(doc?.id)
          .withConverter<lib.LibraryDto>(
          fromFirestore: (snapshot, _) {
            return lib.LibraryDto.fromJson(
                snapshot.data()!);
          },
          toFirestore: (model, _) => model.toJson())
          .get();
      return docSnapshot.data();
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

}