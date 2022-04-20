import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../dto/user_dto.dart' as user;

class AuthRepository {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  DocumentReference? connections;

  Future<user.UserDto?> createAccount(String name, String email, String password) async {

    user.UserDto dto = user.UserDto();
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      print("Account created successful");

      await _fireStore.collection('users').doc(_auth.currentUser?.uid).set({
        "email": email,
        "id": _auth.currentUser?.uid ?? "",
        "name": name,
        "role": "user",
      });

      dto = await firebaseGetUserDetail();

      return dto;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<user.UserDto> firebaseGetUserDetail() async {
    user.UserDto dto = user.UserDto();
    String uid = _auth.currentUser!.uid;

    CollectionReference collRef =
    FirebaseFirestore.instance.collection('users');
    final querySnapshot = await collRef
        .doc(uid)
        .withConverter<user.UserDto>(
        fromFirestore: (snapshot, _) {
          return user.UserDto.fromJson(snapshot.data()!);
        },
        toFirestore: (model, _) => model.toJson())
        .get();

    if(querySnapshot.data() != null){
      dto = querySnapshot.data()!;
    }

    return dto;
  }

}