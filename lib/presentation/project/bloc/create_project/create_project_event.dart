part of 'create_project_bloc.dart';

@freezed
class CreateProjectEvent with _$CreateProjectEvent {
  const factory CreateProjectEvent.started() = _Started;
  const factory CreateProjectEvent.createProject({
    required String name,
    required String features,
  }) = _CreateProject;
}
