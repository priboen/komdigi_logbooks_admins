import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komdigi_logbooks_admins/data/datasources/project_remote_datasources.dart';

part 'delete_project_event.dart';
part 'delete_project_state.dart';
part 'delete_project_bloc.freezed.dart';

class DeleteProjectBloc extends Bloc<DeleteProjectEvent, DeleteProjectState> {
  final ProjectRemoteDatasources datasources;
  DeleteProjectBloc(this.datasources) : super(const _Initial()) {
    on<_DeleteProject>((event, emit) async {
      emit(const _Loading());
      final result = await datasources.deleteProject(event.id);
      result.fold(
        (l) => emit(const _Initial()),
        (r) => emit(const _Success()),
      );
    });
  }
}
