import 'package:app_games/core/dio/exception.dart';
import 'package:app_games/modules/feature_login/data/datasources/remote/login_remote_data_source.dart';
import 'package:app_games/modules/feature_login/domain/repositories/login_repository.dart';
import 'package:dartz/dartz.dart';

class LoginRepositoryImpl extends LoginRepository{
  final RemoteDataSource _remoteDataSource;

  LoginRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, String>> createUser({
    required String name,
    required String email,
    required String uid,
    required int balance,
    required DateTime createdAt,
    String? photoUrl,
  }) async {
    try {
      final result = await _remoteDataSource.createUser(
        email: email,
        name: name,
        uid: uid,
        balance: balance,
        createdAt: createdAt,
        photoUrl: photoUrl,
      );

      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword({
    required String email,
  }) async {
    try {
      final result = await _remoteDataSource.forgotPassword(email: email);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  String? get getLoggedUser => _remoteDataSource.getLoggedUser;

  @override
  Future<Either<Failure, String>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.login(
        email: email,
        password: password,
      );

      return Right(result);
    } on ClientFailure {
      return Left(ClientFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      return Right(await _remoteDataSource.logout());
    } catch (e) {
      return Left(ClientFailure());
    }
  }

  @override
  Future<Either<Failure, String>> register({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteDataSource.register(
        email: email,
        password: password,
      );

      return Right(result);
    } catch (e) {
      return Left(ClientFailure());
    }
  }

  @override
  Future<Either<Failure, String>> sendVerificationEmail() async {
    try {
      final result = await _remoteDataSource.sendEmailVerification();

      return Right(result);
    } catch (e) {
      return Left(ClientFailure());
    }
  }
}