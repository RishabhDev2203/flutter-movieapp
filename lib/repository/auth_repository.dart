import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../dto/user_dto.dart' as user;

class AuthRepository {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  DocumentReference? connections;

  Future<user.UserDto?> createAccount(String name, String email, String password) async {

    user.UserDto dto = user.UserDto();
    user.Result result = user.Result();
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
    user.Result result = user.Result();

    String uid = _auth.currentUser!.uid;
    connections = FirebaseFirestore.instance.collection('users').doc(uid);
    DocumentSnapshot querySnapshot = await connections!.get();
    if (querySnapshot.data() != null) {
      Map<String, dynamic> data = querySnapshot.data() as Map<String, dynamic>;
      result.email = data["email"];
      result.name = data["name"];
      //result.id = data["uid"] ?? "";
      result.aiName = data["role"] ?? "";
      dto.result = result;
      print("result.email ???????????????  ${result.email}");
    }
    return dto;
  }

}