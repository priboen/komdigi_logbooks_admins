part of 'delete_pembimbing_bloc.dart';

@freezed
class DeletePembimbingState with _$DeletePembimbingState {
  const factory DeletePembimbingState.initial() = _Initial;
  const factory DeletePembimbingState.loading() = _Loading;
  const factory DeletePembimbingState.success() = _Success;
  const factory DeletePembimbingState.error(String error) = _Error;
}
