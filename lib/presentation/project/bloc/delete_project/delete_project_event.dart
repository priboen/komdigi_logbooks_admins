part of 'delete_project_bloc.dart';

@freezed
class DeleteProjectEvent with _$DeleteProjectEvent {
  const factory DeleteProjectEvent.started() = _Started;
  const factory DeleteProjectEvent.deleteProject(int id) = _DeleteProject;
}