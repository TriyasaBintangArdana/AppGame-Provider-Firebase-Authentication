import 'package:app_games/core/provider/app_changenotifier.dart';
import 'package:app_games/modules/feature_user/data/models/detail_list_game_models.dart';
import 'package:app_games/modules/feature_user/domain/usecases/user_usecase.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailGameViewModel extends AppChangeNotifier{
  final UserUseCase useCase;

  DetailGameViewModel({required this.useCase});

  bool isLoading = false;
   DetailListGame? detailListGame;

   Future<void> getDetailGame(String id) async{
    isLoading = true;
      notifyListeners();
    try {
      final result = await useCase.detailListGame(id);
      return result.fold(
        (l) {
          throw Exception();
        }, 
        (r) {
          detailListGame = r;
        },
        );
    } catch (e) {
       throw Exception();
    } finally{
       isLoading = false;
      notifyListeners();
    }
  }

  Future<void> generateAndLaunch(String? url) async {
    if (detailListGame?.gameUrl != null) {
      launchUrlString(url ?? "");
    }
  }
  
}