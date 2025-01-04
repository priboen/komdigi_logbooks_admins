import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komdigi_logbooks_admins/data/datasources/project_remote_datasources.dart';

part 'create_project_event.dart';
part 'create_project_state.dart';
part 'create_project_bloc.freezed.dart';

class CreateProjectBloc extends Bloc<CreateProjectEvent, CreateProjectState> {
  final ProjectRemoteDatasources datasources;
  CreateProjectBloc(this.datasources) : super(const _Initial()) {
    on<_CreateProject>((event, emit) async{
      emit(const _Loading());
      final result = await datasources.addProject(event.name, event.features);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Success()),
      );
    });
  }
}
