import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/theme/theme.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_architecture/features/dashboard/presentation/pages/dashboard_screen.dart';
import 'package:flutter_clean_architecture/features/dashboard/presentation/pages/expense_overview_page.dart';
import 'features/auth/data/auth_remote_data_source_impl.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/domain/repositories/auth_repository_impl.dart';
import 'features/auth/domain/usecases/login_usecase.dart';
import 'features/auth/domain/usecases/signup_usecase.dart';
import 'features/auth/presentation/bloc/bloc/auth_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      BlocProvider(

        create: (_) => AuthBloc(

          LoginUseCase(

            AuthRepositoryImpl(

              AuthRemoteDatasourceImpl(
                FirebaseAuth.instance,
              ),
            ),
          ),

          SignupUseCase(

            AuthRepositoryImpl(

              AuthRemoteDatasourceImpl(
                FirebaseAuth.instance,
              ),
            ),
          ),
        ),

        child: const MyApp(),
      )
  );

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authentication',
      theme: AppTheme.darkThemeMode,
      home: SplashScreen() ,
    );
  }
}


