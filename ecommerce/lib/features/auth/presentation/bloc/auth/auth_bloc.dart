import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecase.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../../domain/usecases/login.dart';
import '../../../domain/usecases/logout.dart';
import '../../../domain/usecases/signup.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final Signup signup;
  final Logout logout;
  final AuthRepository authRepository;

  AuthBloc({
    required this.login,
    required this.signup,
    required this.logout,
    required this.authRepository,
  }) : super(const AuthState()) {
    on<AuthCheckRequested>(_onCheck);
    on<AuthLoginRequested>(_onLogin);
    on<AuthSignupRequested>(_onSignup);
    on<AuthLogoutRequested>(_onLogout);
  }

  Future<void> _onCheck(AuthCheckRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await authRepository.getCachedUser();
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, user: null, errorMessage: null)),
      (user) => emit(state.copyWith(isLoading: false, user: user, errorMessage: null)),
    );
  }

  Future<void> _onLogin(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await login(LoginParams(email: event.email, password: event.password));
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, errorMessage: l.message)),
      (user) => emit(state.copyWith(isLoading: false, user: user)),
    );
  }

  Future<void> _onSignup(AuthSignupRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await signup(SignupParams(name: event.name, email: event.email, password: event.password));
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, errorMessage: l.message)),
      (user) => emit(state.copyWith(isLoading: false, user: user)),
    );
  }

  Future<void> _onLogout(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await logout(NoParams());
    result.fold(
      (l) => emit(state.copyWith(isLoading: false, errorMessage: l.message)),
      (_) => emit(const AuthState(isLoading: false, user: null)),
    );
  }
}


