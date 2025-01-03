part of 'delete_pembimbing_bloc.dart';

@freezed
class DeletePembimbingEvent with _$DeletePembimbingEvent {
  const factory DeletePembimbingEvent.started() = _Started;
  const factory DeletePembimbingEvent.deletePembimbing(int id) = _DeletePembimbing;
}