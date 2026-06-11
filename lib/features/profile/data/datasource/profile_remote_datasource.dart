import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class ProfileRemoteDatasource {

  final FirebaseFirestore firestore;

  ProfileRemoteDatasource(
      this.firestore,
      );

  Future<void> saveUser(
      UserModel user,
      ) async {

    await firestore
        .collection('users')
        .doc(user.uid)
        .set(
      user.toMap(),
    );
  }

  Future<UserModel> getUser(
      String uid,
      ) async {

    final doc = await firestore
        .collection('users')
        .doc(uid)
        .get();

    return UserModel.fromMap(
      doc.data()!,
    );
  }
}