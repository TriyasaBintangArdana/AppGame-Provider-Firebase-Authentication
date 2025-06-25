import 'dart:io';

import 'package:app_games/core/dio/exception.dart';
import 'package:app_games/modules/feature_login/domain/entities/authentication_user.dart';
import 'package:app_games/modules/feature_user/data/models/detail_list_game_models.dart';
import 'package:app_games/modules/feature_user/data/models/list_all_game_models.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
   Future<Either<Failure, AuthenticationUser>> getUser();
  Future<Either<Failure, AuthenticationUser>> updateProfileUser({required AuthenticationUser user});
  Future<Either<Failure, String>> uploadProfilePicture({
    required String uid,
    required File image,
  });
  Future<Either<Failure, String>> changePassword({
    required String newPassword,
    required String email,
    required String oldPassword,
  });
  Future<Either<Failure, void>> logout();
  Future<Either<Failure,List<ListAllGame>>> getAllGames();
  Future<Either<Failure,List<ListAllGame>>> getAllGamesByCategory(String? category);
  Future<Either<Failure,List<ListAllGame>>> getAllGamesByPlatform(String? platform);
  Future<Either<Failure,List<ListAllGame>>> getAllGamesByPlatformCategory(String? category,String? platform);
  Future<Either<Failure,List<ListAllGame>>> getFavoriteGame();
  Future<Either<Failure,DetailListGame>> detailListGame(String? id);
  Future<Either<Failure,ListAllGame>> saveInsertFavGame(ListAllGame game);
  Future<Either<Failure,void>> removeFavGame(int? id);
}