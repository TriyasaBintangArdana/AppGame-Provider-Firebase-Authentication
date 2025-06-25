import 'package:app_games/core/dio/exception.dart';
import 'package:app_games/core/provider/app_changenotifier.dart';
import 'package:app_games/modules/feature_login/data/datasources/local/app_shared_preferences.dart';
import 'package:app_games/modules/feature_login/domain/usecases/login_usecase.dart';
import 'package:app_games/modules/feature_login/presentation/state/login_state.dart';

class LoginViewModel extends AppChangeNotifier{
  final LoginUseCase useCase;
  final AppSharedPreferences sharedPreferences;
  LoginViewModel({required this.useCase,required this.sharedPreferences});

  bool isLoading = false;

  Future<LoginState> login(String email, String password) async{
    try {
      isLoading = true;
      notifyListeners();
      final result = await useCase.login(email: email,password:password);
      return result.fold(
        (l) {
         if (l is ServerFailure) {
            return const LoginState.serverError();
          }
          return const LoginState.clientError();
        },
        (r) {
           return const LoginState.success();
        },
      );
    } catch (e) {
       return const LoginState.clientError();
    }finally {
      isLoading = false;
    }
  }

  Future<LoginState> forgotPassword(String email) async {
    try {
      isLoading = true;
      notifyListeners();
      final result = await useCase.forgotPassword(email: email);
      return result.fold(
        (l) {
          if (l is ServerFailure) {
            return const LoginState.serverError();
          }
          return const LoginState.clientError();
        },
        (r) {
          return const LoginState.success();
        },
      );
    } catch (e) {
      return const LoginState.clientError();
    } finally {
      isLoading = false;
    }
  }

  String get getLoggedUser => useCase.getLoggedUser ?? '';
}