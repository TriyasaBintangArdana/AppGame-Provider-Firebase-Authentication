import 'package:app_games/core/dio/exception.dart';
import 'package:dartz/dartz.dart';

abstract class LoginRepository {
  Future<Either<Failure, String>> register({
    required String email,
    required String password,
  });
  Future<Either<Failure, String>> createUser({
    required String name,
    required String email,
    required String uid,
    required int balance,
    required DateTime createdAt,
    String? photoUrl,
  });
  Future<Either<Failure, String>> login({
    required String email,
    required String password,
  });
  Future<Either<Failure, String>> sendVerificationEmail();
  Future<Either<Failure, String>> forgotPassword({
    required String email,
  });
  Future<Either<Failure, void>> logout();
  String? get getLoggedUser;
}