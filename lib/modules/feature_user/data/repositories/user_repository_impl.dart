import 'dart:io';

import 'package:app_games/core/dio/exception.dart';
import 'package:app_games/core/error/api_exception2.dart';
import 'package:app_games/modules/feature_login/data/models/user_model.dart';
import 'package:app_games/modules/feature_login/domain/entities/authentication_user.dart';
import 'package:app_games/modules/feature_user/data/datasources/user_data_source.dart';
import 'package:app_games/modules/feature_user/data/models/detail_list_game_models.dart';
import 'package:app_games/modules/feature_user/data/models/list_all_game_models.dart';
import 'package:app_games/modules/feature_user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository{
  final UserDataSource _remoteDataSource;

  UserRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, AuthenticationUser>> getUser() async {
    try {
      final model = await _remoteDataSource.getUser();
      return Right(model.toEntity());
    } catch (e) {
      return Left(ClientFailure());
    }
  }

  @override
  Future<Either<Failure, AuthenticationUser>> updateProfileUser({required AuthenticationUser user}) async {
    try {
      final model = await _remoteDataSource.updateProfileUser(
          user: UserModel.fromEntity(user));
      return Right(model.toEntity());
    } catch (e) {
      return Left(ClientFailure());
    }
  }

  @override
  Future<Either<Failure,String>> uploadProfilePicture({
    required String uid,
    required File image,
  }) async {
    try {
      final result =
          await _remoteDataSource.uploadProfilePicture(uid: uid, image: image);
      return Right(result);
    } catch (e) {
      return Left(ClientFailure());
    }
  }

  @override
  Future<Either<Failure, String>> changePassword({
    required String newPassword,
    required String email,
    required String oldPassword,
  }) async {
    try {
      final result = await _remoteDataSource.changePassword(
        newPassword: newPassword,
        email: email,
        oldPassword: oldPassword,
      );
      return Right(result);
    } catch (e) {
      return Left(ClientFailure());
    }
  }
  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final result = await _remoteDataSource.logout();
      return Right(result);
    } catch (e) {
      return Left(ClientFailure());
    }
  }

  @override
  Future<Either<Failure,List<ListAllGame>>> getAllGames() async{
    try {
      final res = await _remoteDataSource.getAllGames();
      return Right(res);
    } on ServerErrorException{
      return const Left(ServerFailure());
    } on ClientErrorException{
      return const Left(ClientFailure());
    }
    catch (e) {
      return const Left(ClientFailure());
    }
  }
  @override
  Future<Either<Failure,List<ListAllGame>>> getAllGamesByCategory(String? category) async{
    try {
      final res = await _remoteDataSource.getAllGamesByCategory(category);
      return Right(res);
    } on ServerErrorException{
      return const Left(ServerFailure());
    } on ClientErrorException{
      return const Left(ClientFailure());
    }
    catch (e) {
      return const Left(ClientFailure());
    }
  }
  @override
  Future<Either<Failure,List<ListAllGame>>> getAllGamesByPlatform(String? platform) async{
    try {
      final res = await _remoteDataSource.getAllGamesByPlatform(platform);
      return Right(res);
    } on ServerErrorException{
      return const Left(ServerFailure());
    } on ClientErrorException{
      return const Left(ClientFailure());
    }
    catch (e) {
      return const Left(ClientFailure());
    }
  }
  @override
  Future<Either<Failure,List<ListAllGame>>> getAllGamesByPlatformCategory(String? category,String?platform) async{
    try {
      final res = await _remoteDataSource.getAllGamesByPlatformCategory(category,platform);
      return Right(res);
    } on ServerErrorException{
      return const Left(ServerFailure());
    } on ClientErrorException{
      return const Left(ClientFailure());
    }
    catch (e) {
      return const Left(ClientFailure());
    }
  }

  @override
  Future<Either<Failure,DetailListGame>> detailListGame(String? id) async{
    try {
      final res = await _remoteDataSource.detailListGame(id);
      return Right(res);
    } on ServerErrorException{
      return const Left(ServerFailure());
    } on ClientErrorException{
      return const Left(ClientFailure());
    }
    catch (e) {
      return const Left(ClientFailure());
    }
  }

  @override
  Future<Either<Failure,List<ListAllGame>>> getFavoriteGame() async{
    try {
      final res = await _remoteDataSource.getFavoriteGame();
      return Right(res);
    } on ServerErrorException{
      return const Left(ServerFailure());
    } on ClientErrorException{
      return const Left(ClientFailure());
    }
    catch (e) {
      return const Left(ClientFailure());
    }
  }
  @override
  Future<Either<Failure,ListAllGame>> saveInsertFavGame(ListAllGame game) async{
    try {
      final res = await _remoteDataSource.saveInsertFavGame(game);
      return Right(res);
    } on ServerErrorException{
      return const Left(ServerFailure());
    } on ClientErrorException{
      return const Left(ClientFailure());
    }
    catch (e) {
      return const Left(ClientFailure());
    }
  }
  @override
  Future<Either<Failure,void>> removeFavGame(int? id) async{
    try {
      final res = await _remoteDataSource.removeFavGame(id);
      return Right(res);
    } on ServerErrorException{
      return const Left(ServerFailure());
    } on ClientErrorException{
      return const Left(ClientFailure());
    }
    catch (e) {
      return const Left(ClientFailure());
    }
  }
}