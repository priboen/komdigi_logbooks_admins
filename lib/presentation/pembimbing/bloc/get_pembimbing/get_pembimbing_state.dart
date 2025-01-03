part of 'get_pembimbing_bloc.dart';

@freezed
class GetPembimbingState with _$GetPembimbingState {
  const factory GetPembimbingState.initial() = _Initial;
  const factory GetPembimbingState.loading() = _Loading;
  const factory GetPembimbingState.success(List<Pembimbing> pembimbing) = _Success;
  const factory GetPembimbingState.error(String error) = _Error;
}
