part of 'delete_project_bloc.dart';

@freezed
class DeleteProjectState with _$DeleteProjectState {
  const factory DeleteProjectState.initial() = _Initial;
  const factory DeleteProjectState.loading() = _Loading;
  const factory DeleteProjectState.success() = _Success;
}
