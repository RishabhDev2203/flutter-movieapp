import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_ott/dto/content_dto.dart';
import 'package:flutter_firebase_ott/dto/library_dto.dart'as lib;

class HomeRepository {

  Future<List<lib.LibraryDto?>?> getBannerMovies({bool enableMock = false}) async {
    var list;
    var data;
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

      list = querySnapshot.docs.map((e) {
        return e.data();
      }).toList();

      return list;
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
    print("docSnapshot.data()>>>>>>>>>>>>> ${docSnapshot.data()?.outputUrl}");
    return docSnapshot.data();
  }

}