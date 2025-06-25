import 'dart:io';

import 'package:app_games/core/provider/app_changenotifier.dart';
import 'package:app_games/modules/feature_login/domain/entities/authentication_user.dart';
import 'package:app_games/modules/feature_user/data/models/list_all_game_models.dart';
import 'package:app_games/modules/feature_user/domain/usecases/user_usecase.dart';
import 'package:app_games/modules/feature_user/presentation/state/request_state.dart';

class HomeViewModel extends AppChangeNotifier {
  final UserUseCase useCase;
  HomeViewModel({required this.useCase});

  bool isLoading = false;
  AuthenticationUser? user;
  List<ListAllGame?> listGame = [];

  Future<RequestState> getUser() async {
    try {
      isLoading = true;
      notifyListeners();
      final result = await useCase.getUser();
      return result.fold(
        (l) {
          return RequestState.error();
        },
        (r) {
          user = r;
          return RequestState.success();
        },
      );
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<RequestState> changePassword({
    required String newPassword,
    required String email,
    required String oldPassword,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      final result = await useCase.changePassword(
        newPassword: newPassword,
        email: email,
        oldPassword: oldPassword,
      );
      return result.fold(
        (l) {
          return RequestState.error();
        },
        (r) {
          return RequestState.success();
        },
      );
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  Future<RequestState> updateProfile({required AuthenticationUser user}) async {
    try {
      isLoading = true;
      notifyListeners();
      final result = await useCase.updateProfileUser(user: user);
      return result.fold(
        (l) {
          return RequestState.error();
        },
        (r) {
          return RequestState.success();
        },
      );
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
Future<String> uploadPhotoProfile({
  required File file,
  required String uuid,
}) async {
  try {
    isLoading = true;
    notifyListeners();

    final result = await useCase.uploadProfileUser(image: file, uid: uuid);

    return result.fold(
      (l) {
        print("Ini L : $l");
        return '';
      },
      (r){
        print("ini R : $r");
       return r;
      } 
    );
  } catch (e) {
    print(e);
    rethrow;
  } finally {
    isLoading = false;
    notifyListeners();
  }
}


  Future<RequestState> getAllGame() async {
    try {
      isLoading = true;
      notifyListeners();

      final result = await useCase.getAllGame();
      return result.fold(
        (failure) {
          return RequestState.error();
        },
        (r) {
          listGame = r;
          return RequestState.success();
        },
      );
    } catch (e) {
      return RequestState.error();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      isLoading = true;
      notifyListeners();
      final result = await useCase.logout();
      result.fold(
        (l) {
          return RequestState.error();
        },
        (r) {
          return RequestState.success();
        },
      );
    } catch (e) {
      rethrow;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<RequestState> insertFav(ListAllGame game) async{
    try {
      isLoading = true;
      notifyListeners();
      final result = await useCase.saveInsertFavGame(game);
      return result.fold(
        (l) { 
          return RequestState.error();
        }, 
        (r) { 
          return RequestState.success();
        },
        );
    } catch (e) {
      rethrow;
    } finally{
      isLoading= false;
      notifyListeners();
    }
  }
  Future<RequestState> getFav() async{
    try {
      isLoading = true;
      notifyListeners();
      final result = await useCase.getFavoriteGame();
      return result.fold(
        (l) { 
          return RequestState.error();
        }, 
        (r) { 
          listGame = r;
          return RequestState.success();
        },
        );
    } catch (e) {
      rethrow;
    } finally{
      isLoading= false;
      notifyListeners();
    }
  }
}
