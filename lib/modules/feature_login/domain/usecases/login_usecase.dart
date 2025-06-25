import 'package:app_games/core/dio/exception.dart';
import 'package:app_games/modules/feature_login/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
   final LoginRepository _repository;

  LoginUseCase(this._repository);

  Future<Either<Failure, String>> createUser({
    required String name,
    required String email,
    required String uid,
    required int balance,
    required DateTime createdAt,
    String? photoUrl,
  }) async {
    return _repository.createUser(
      name: name,
      email: email,
      uid: uid,
      balance: balance,
      createdAt: createdAt,
      photoUrl: photoUrl,
    );
  }
  Future<Either<Failure, String>> forgotPassword({required String email}) async {
    return _repository.forgotPassword(email: email);
  }

   String? get getLoggedUser => _repository.getLoggedUser;

   Future<Either<Failure, String>> login({
    required String email,
    required String password,
  }) async {
    return _repository.login(email: email, password: password);
  }

  Future<Either<Failure, void>> logout() async {
    return _repository.logout();
  }

  Future<Either<Failure, String>> register({
    required String email,
    required String password,
  }) async {
    return _repository.register(email: email, password: password);
  }

  Future<Either<Failure, String>> sendVerificationEmail() async {
    return _repository.sendVerificationEmail();
  }
}