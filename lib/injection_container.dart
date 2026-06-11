
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'features/auth/data/auth_remote_data_source_impl.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';


import 'features/auth/domain/repositories/auth_repository.dart';

import 'features/auth/domain/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/signup_usecase.dart';

import 'features/auth/presentation/bloc/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {

  // Firebase
  sl.registerLazySingleton(
        () => FirebaseAuth.instance,
  );

  // DataSource
  sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDatasourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(sl()),
  );

  // UseCases
  sl.registerLazySingleton(
        () => LoginUseCase(sl()),
  );

  sl.registerLazySingleton(
        () => SignupUseCase(sl()),
  );

  // Bloc
  sl.registerFactory(
        () => AuthBloc(sl(), sl()),
  );
}