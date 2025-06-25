import 'dart:io';

import 'package:app_games/core/db/db.dart';
import 'package:app_games/core/dio/api_base_helper.dart';
import 'package:app_games/modules/feature_login/data/models/user_model.dart';
import 'package:app_games/modules/feature_user/data/models/detail_list_game_models.dart';
import 'package:app_games/modules/feature_user/data/models/list_all_game_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class UserDataSource {
Future<UserModel> getUser({String? uid});
  Future<UserModel> updateProfileUser({required UserModel user});
  Future<String> uploadProfilePicture({
    required String uid,
    required File image,
  });
  Future<String> changePassword({
    required String newPassword,
    required String email,
    required String oldPassword,
  });
  Future<void> logout();
  //
  Future<List<ListAllGame>>getFavoriteGame();
  Future<ListAllGame>saveInsertFavGame(ListAllGame game);
  Future<void> removeFavGame(int? id);

  Future<List<ListAllGame>> getAllGames();
  Future<List<ListAllGame>> getAllGamesByCategory(String? category);
  Future<List<ListAllGame>> getAllGamesByPlatform(String? platform);
  Future<List<ListAllGame>> getAllGamesByPlatformCategory(String? platform,String? category);
  Future<DetailListGame> detailListGame(String? id);
}

class UserDataSourceImpl implements UserDataSource{
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;
  final FirebaseAuth _firebaseAuth;
  final ApiBaseHelper apiBaseHelper;
  final DBHelper dbHelper;

  UserDataSourceImpl(
    this._firestore,
    this._storage,
    this._firebaseAuth,
    this.apiBaseHelper,
    this.dbHelper
  );

//FIREBASE
  @override
  Future<UserModel> getUser({String? uid}) async {
    try {
      final userId = uid ?? _firebaseAuth.currentUser?.uid;

    if (userId == null) {
      throw 'User belum login';
    }
      final docSnap = await _firestore.collection('user').doc(userId).get();
      if (!docSnap.exists) {
      throw 'Data user tidak ditemukan';
    }
      return UserModel.fromFirestore(docSnap.data()!);
    } on FirebaseException catch (e) {
      throw e.toString();
    }
  }


  @override
  Future<UserModel> updateProfileUser({required UserModel user}) async {
    final docRef = _firestore.collection('user').doc(user.uid);

    await docRef.update({
      'uid': user.uid,
      'email': user.email,
      'name': user.name,
      'created_at': user.createdAt?.millisecondsSinceEpoch,
      'balance': user.balance,
      'photo_url': user.photoUrl,
    });

    final docSnap = await docRef.get();

    if (docSnap.exists) {
      return UserModel.fromFirestore(docSnap.data()!);
    } else {
      throw 'Gagal Update Profile';
    }
  }

  @override
  Future<String> uploadProfilePicture({
    required String uid,
    required File image,
  }) async {
    try {
      final storageUser = _storage.ref('user').child(uid);

      await storageUser.putFile(image);

      return await storageUser.getDownloadURL();
    } on FirebaseException catch (e) {
      print("Upload error: $e");
      throw e.toString();
    }
  }

  @override
  Future<String> changePassword({
    required String newPassword,
    required String email,
    required String oldPassword,
  }) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: oldPassword,
      );

      await result.user?.updatePassword(newPassword);
      return 'Berhasil ganti password';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw 'User tidak ditemukan';
      } else if (e.code == 'wrong-password') {
        throw 'Sandi salah';
      } else {
        throw 'Sandi sebelumnya yang anda masukkan salah';
      }
    }
  }

    @override
  Future<void> logout() async {
    return await _firebaseAuth.signOut();
  }
//FIREBASE END

//DB
  @override
  Future<List<ListAllGame>>getFavoriteGame()async{
    final result = await dbHelper.getFavoviteGame();
    return result!.map((e) => ListAllGame.fromJson(e)).toList();
  }

  @override
  Future<ListAllGame>saveInsertFavGame(ListAllGame game) async{
    try {
      final result = await dbHelper.insertGame(game);
      print("Insert success: $result");
      return ListAllGame.fromJson(result);
    } catch (e) {
      print("Insert failed: $e");
      throw e.toString();
    }
  }

  @override
  Future<void>removeFavGame(int? id) async{
    try {
      return await dbHelper.deleteFavMovie(id!);
    } catch (e) {
      throw e.toString();
    }
  }
//DB END

//FROM API
  @override
  Future<List<ListAllGame>> getAllGames() async{
    try {
      final response = await apiBaseHelper.get("https://www.freetogame.com/api/games");
      final List<dynamic> jsonList = response.data;
    return jsonList.map((json) => ListAllGame.fromJson(json)).toList();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<ListAllGame>>getAllGamesByCategory(String? category) async {
    try {
      final queryParams = {
        "category" : category
      };
      final response = await apiBaseHelper.get("https://www.freetogame.com/api/games",
      data: queryParams);
      final List<dynamic> jsonList = response.data;
    return jsonList.map((json) => ListAllGame.fromJson(json)).toList();
    } catch (e) {
      throw Exception();
    }
  }
  @override
  Future<List<ListAllGame>>getAllGamesByPlatform(String? platform) async {
    try {
      final queryParams = {
        "platform" : platform
      };
      final response = await apiBaseHelper.get("https://www.freetogame.com/api/games",
      data: queryParams);
      final List<dynamic> jsonList = response.data;
    return jsonList.map((json) => ListAllGame.fromJson(json)).toList();
    } catch (e) {
      throw Exception();
    }
  }
  @override
  Future<List<ListAllGame>>getAllGamesByPlatformCategory(String? category, String? platform) async {
    try {
      final queryParams = {
        "category" : category,
        "platform" : platform
      };
      final response = await apiBaseHelper.get("https://www.freetogame.com/api/games",
      data: queryParams);
      final List<dynamic> jsonList = response.data;
    return jsonList.map((json) => ListAllGame.fromJson(json)).toList();
    } catch (e) {
      throw Exception();
    }
  }

   @override
  Future<DetailListGame>detailListGame(String? id) async {
    try {
      final queryParams = {
        "id" : id
      };
      final response = await apiBaseHelper.get("https://www.freetogame.com/api/game",
      data: queryParams);
      final data = DetailListGame.fromJson(response.data);
      return data;
    } catch (e) {
      throw Exception();
    }
  }
//FROM API END
}