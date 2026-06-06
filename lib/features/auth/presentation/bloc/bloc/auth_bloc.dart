import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/login_usecase.dart';
import '../../../domain/usecases/signup_usecase.dart';
import '../events/auth_event.dart';
import '../states/auth_state.dart';
class AuthBloc
    extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;
  AuthBloc(
      this.loginUseCase,
      this.signupUseCase,
      ) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await loginUseCase(
          event.email,
          event.password,
        );
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
    on<SignupEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await signupUseCase(
          event.email,
          event.password,
        );
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}