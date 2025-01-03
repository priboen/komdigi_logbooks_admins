part of 'add_pembimbing_bloc.dart';

@freezed
class AddPembimbingEvent with _$AddPembimbingEvent {
  const factory AddPembimbingEvent.started() = _Started;
  const factory AddPembimbingEvent.addPembimbing({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) = _AddPembimbing;
}