import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {

  Future<UserCredential> login(
      String email,
      String password,
      );

  Future<UserCredential> signup(
      String email,
      String password,
      );

  Future<void> logout();
  User? getCurrentUser();
}

// class AuthRemoteDatasourceImpl
//     implements AuthRemoteDataSource {
//
//   final FirebaseAuth firebaseAuth;
//
//   AuthRemoteDatasourceImpl(this.firebaseAuth);
//
//   @override
//   Future<UserCredential> login(
//       String email,
//       String password,
//       ) async {
//
//     return await firebaseAuth
//         .signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//
//
//   }
//
//   @override
//   Future<UserCredential> signup(
//       String email,
//       String password,
//       ) async {
//
//     return await firebaseAuth
//         .createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//   }
//
//   @override
//   User? getCurrentUser(){
//
//   return firebaseAuth.currentUser;
//   }
//
//   @override
//   Future<void> logout() async{
//
//     await firebaseAuth.signOut();
//   }
// }