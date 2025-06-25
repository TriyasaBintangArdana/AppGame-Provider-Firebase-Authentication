import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_state.freezed.dart';

@freezed
class RequestState with _$RequestState {
  const factory RequestState.error({String? message}) = _RequestStateErrorState;
  const factory RequestState.success() = _RequestStateSuccessState;
}
