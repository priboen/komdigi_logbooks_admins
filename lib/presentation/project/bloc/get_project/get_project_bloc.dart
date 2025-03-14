import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komdigi_logbooks_admins/data/datasources/project_remote_datasources.dart';
import 'package:komdigi_logbooks_admins/data/model/responses/project_response_model.dart';

part 'get_project_event.dart';
part 'get_project_state.dart';
part 'get_project_bloc.freezed.dart';

class GetProjectBloc extends Bloc<GetProjectEvent, GetProjectState> {
  final ProjectRemoteDatasources datasources;
  GetProjectBloc(this.datasources) : super(const _Initial()) {
    on<GetProjectEvent>((event, emit) async {
      emit(const _Loading());
      final result = await datasources.getProject();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Success(r.data ?? [])),
      );
    });
  }
}
