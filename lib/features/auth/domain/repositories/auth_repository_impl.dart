import '../../data/datasources/auth_remote_data_source.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl
    implements AuthRepository {

  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> login(
      String email,
      String password,
      ) async {

    await remoteDataSource.login(
      email,
      password,
    );
  }

  @override
  Future<void> signup(
      String email,
      String password,
      ) async {

    await remoteDataSource.signup(
      email,
      password,
    );
  }

  @override
  Future<void> logout() async {
    await remoteDataSource.logout();
  }
}