import 'package:firebase_auth/firebase_auth.dart';

import 'datasources/auth_remote_data_source.dart';

class AuthRemoteDatasourceImpl
    implements AuthRemoteDataSource {

  final FirebaseAuth firebaseAuth;

  AuthRemoteDatasourceImpl(this.firebaseAuth);

  @override
  Future<UserCredential> login(
      String email,
      String password,
      ) async {

    return await firebaseAuth
        .signInWithEmailAndPassword(
      email: email,
      password: password,
    );

  }

  @override
  Future<UserCredential> signup(
      String email,
      String password,
      ) async {

    return await firebaseAuth
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  User? getCurrentUser(){

  return firebaseAuth.currentUser;
  }

  @override
  Future<void> logout() async{

    await firebaseAuth.signOut();
  }
}