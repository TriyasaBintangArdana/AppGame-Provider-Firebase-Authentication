
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.serverError() = _LoginServerErrorState;
  const factory LoginState.clientError() = _LoginClientErrorState;
  const factory LoginState.success() = _LoginSuccessState;
}
