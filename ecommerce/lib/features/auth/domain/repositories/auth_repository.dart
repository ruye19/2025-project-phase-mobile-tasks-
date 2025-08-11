import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({required String email, required String password});
  Future<Either<Failure, User>> signup({required String name, required String email, required String password});
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User?>> getCachedUser();
}


