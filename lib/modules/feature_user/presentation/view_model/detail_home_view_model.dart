import 'package:app_games/core/provider/app_changenotifier.dart';
import 'package:app_games/modules/feature_user/data/models/list_all_game_models.dart';
import 'package:app_games/modules/feature_user/data/models/list_game_category_models.dart';
import 'package:app_games/modules/feature_user/domain/usecases/user_usecase.dart';
import 'package:app_games/modules/feature_user/presentation/state/request_state.dart';

class DetailHomeViewModel extends AppChangeNotifier {
  final UserUseCase useCase;
  DetailHomeViewModel({
    required this.useCase
  });
  bool isLoading = false;
  List<ListAllGame?> listGame = [];
  List<ListGameCategory?> listGameCategory = [];

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

  Future<RequestState> getGameByCategory(String? category) async {
    try {
      isLoading = true;
      notifyListeners();

      final result = await useCase.getAllGameByCategory(category);
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

  Future<RequestState> getGameByPlatform(String? platform) async {
    try {
      isLoading = true;
      notifyListeners();

      final result = await useCase.getAllGameByPlatform(platform);
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

   Future<RequestState> getAllGameByCategoryAndPlatform(
    String? category,
    String? platform,
  ) async {
    try {
      isLoading = true;
    notifyListeners();

    final result = await useCase.getAllGameByCategoryAndPlatform(
      category,
      platform,
    );
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
}