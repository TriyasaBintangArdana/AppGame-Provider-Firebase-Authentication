import 'dart:io';

import 'package:app_games/core/dio/exception.dart';
import 'package:app_games/modules/feature_login/domain/entities/authentication_user.dart';
import 'package:app_games/modules/feature_user/data/models/detail_list_game_models.dart';
import 'package:app_games/modules/feature_user/data/models/list_all_game_models.dart';
import 'package:app_games/modules/feature_user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserUseCase{
   final UserRepository _repository;

  UserUseCase(this._repository);

  Future<Either<Failure, String>> changePassword({
    required String newPassword,
    required String email,
    required String oldPassword,
  }) async {
    return _repository.changePassword(
      newPassword: newPassword,
      email: email,
      oldPassword: oldPassword,
    );
  }
  Future<Either<Failure, AuthenticationUser>> getUser() async {
  final result = await _repository.getUser();
  return result;
  }
  Future<Either<Failure, AuthenticationUser>> updateProfileUser({required AuthenticationUser user}) async {
    return _repository.updateProfileUser(user: user);
  }

  Future<Either<Failure,String>> uploadProfileUser({
    required String uid,
    required File image,
  }) async {
    return _repository.uploadProfilePicture(uid: uid, image: image);
  }

    Future<Either<Failure,void>> logout(){
    return _repository.logout();
  }
   Future<Either<Failure,List<ListAllGame>>> getAllGame()  {
    return _repository.getAllGames();
  }
  Future<Either<Failure,List<ListAllGame>>> getAllGameByCategory(String? category){
    return _repository.getAllGamesByCategory(category);
  }
  Future<Either<Failure,List<ListAllGame>>> getAllGameByPlatform(String? platform){
    return _repository.getAllGamesByPlatform(platform);
  }
  Future<Either<Failure,List<ListAllGame>>> getAllGameByCategoryAndPlatform(String?category,String? platform){
    return _repository.getAllGamesByPlatformCategory(category,platform);
  }
  Future<Either<Failure,DetailListGame>> detailListGame(String? id){
    return _repository.detailListGame(id);
  }
  Future<Either<Failure,List<ListAllGame>>> getFavoriteGame(){
    return _repository.getFavoriteGame();
  }
  Future<Either<Failure,ListAllGame>> saveInsertFavGame(ListAllGame game){
    return _repository.saveInsertFavGame(game);
  }
  Future<Either<Failure,void>> removeFavGame(int? id){
    return _repository.removeFavGame(id);
  }
}