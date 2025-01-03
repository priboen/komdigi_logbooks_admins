import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komdigi_logbooks_admins/data/datasources/pembimbing_remote_datasources.dart';

part 'delete_pembimbing_event.dart';
part 'delete_pembimbing_state.dart';
part 'delete_pembimbing_bloc.freezed.dart';

class DeletePembimbingBloc
    extends Bloc<DeletePembimbingEvent, DeletePembimbingState> {
  final PembimbingRemoteDatasources datasource;
  DeletePembimbingBloc(this.datasource) : super(const _Initial()) {
    on<_DeletePembimbing>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.deletePembimbing(event.id);
      result.fold((l) => emit(_Error(l)), (r) => emit(const _Success()));
    });
  }
}
