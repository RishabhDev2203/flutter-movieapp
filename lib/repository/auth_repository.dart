import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../dto/user_dto.dart' as user;
import '../util/app_session.dart';

class AuthRepository {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  DocumentReference? connections;

  Future<user.UserDto?> createAccount(String name, String email, String password, {bool enableMock = false}) async {

    user.UserDto dto = user.UserDto();

    if(enableMock)  {




      return dto;
    }

    FirebaseFirestore _fireStore = FirebaseFirestore.instance;

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await _fireStore.collection('users').doc(_auth.currentUser?.uid).set({
        "email": email,
        "id": _auth.currentUser?.uid ?? "",
        "name": name,
        "role": "user",
      });

      dto = await firebaseGetUserDetail();
      return dto;
    } on FirebaseException catch (e) {
      rethrow;
    }
  }
  Future<user.UserDto?> loginAccount(String email, String password, {bool enableMock = false}) async {

    user.UserDto dto = user.UserDto();

    if(enableMock)  {




      return dto;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      dto = await firebaseGetUserDetail();
      return dto;
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  Future logoutAccount() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.signOut();
      AppSession().removeUserDetail();
    } on FirebaseException catch (e) {
      rethrow;
    }
  }
  Future changePassword(String currentPassword,String newPassword) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    User? currentUser = _auth.currentUser;
    String? email = currentUser?.email;
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.toString(),
        password: currentPassword,
      );
      currentUser?.updatePassword(newPassword);

    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  Future<user.UserDto?> apiGoogleLogin(String email, String name) async {
    user.UserDto dto = user.UserDto();
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email, password: "qwerty");

      //await _auth.signInWithCredential(credential);
      dto = await firebaseGetUserDetail();
      return dto;
    } on FirebaseException catch (e) {
      rethrow;
    }
  }

  Future forgotPassword(String email) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseException catch (e) {
      rethrow;
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