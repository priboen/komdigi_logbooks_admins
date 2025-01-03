part of 'add_pembimbing_bloc.dart';

@freezed
class AddPembimbingState with _$AddPembimbingState {
  const factory AddPembimbingState.initial() = _Initial;
  const factory AddPembimbingState.loading() = _Loading;
  const factory AddPembimbingState.success() = _Success;
  const factory AddPembimbingState.error(String error) = _Error;
}
