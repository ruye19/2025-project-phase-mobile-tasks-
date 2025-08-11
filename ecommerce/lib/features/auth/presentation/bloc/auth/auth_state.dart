import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';

class AuthState extends Equatable {
  final bool isLoading;
  final User? user;
  final String? errorMessage;

  const AuthState({this.isLoading = false, this.user, this.errorMessage});

  AuthState copyWith({bool? isLoading, User? user, String? errorMessage}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, user, errorMessage];
}


