import 'package:app_games/core/dio/exception.dart';
import 'package:app_games/core/provider/app_changenotifier.dart';
import 'package:app_games/modules/feature_login/domain/entities/authentication_user.dart';
import 'package:app_games/modules/feature_login/domain/usecases/login_usecase.dart';
import 'package:app_games/modules/feature_login/presentation/state/login_state.dart';

class RegisterViewModel extends AppChangeNotifier {
  final LoginUseCase useCase;
  RegisterViewModel({required this.useCase});

  bool isLoading = false;
  AuthenticationUser? user;

  Future<LoginState> createUser() async {
    await Future.delayed(const Duration(seconds: 5));
    final result = await useCase.createUser(
      email: user?.email ?? "",
      balance: user?.balance ?? 0,
      createdAt: DateTime.now(),
      name: user?.name ?? "",
      uid: user?.uid ?? "",
      photoUrl: user?.photoUrl ?? "",
    );
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
  }

  Future<LoginState> register(String email, String password,String userName) async {
    try {
      isLoading = true;
      notifyListeners();
      final result = await useCase.register(email: email, password: password);
      return result.fold(
        (l) {
          if (l is ServerFailure) {
            return const LoginState.serverError();
          }
          return const LoginState.clientError();
        },
        (r) async {
          user = AuthenticationUser(
            uid: r,
            email: email,
            name: userName,
            balance: 0,
            createdAt: DateTime.now(),
            photoUrl: "",
          );
          return await createUser();
        },
      );
    } catch (e) {
      return const LoginState.clientError();
    } finally {
      isLoading = false;
    }
  }
}
