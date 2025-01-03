import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komdigi_logbooks_admins/data/datasources/pembimbing_remote_datasources.dart';

part 'add_pembimbing_event.dart';
part 'add_pembimbing_state.dart';
part 'add_pembimbing_bloc.freezed.dart';

class AddPembimbingBloc extends Bloc<AddPembimbingEvent, AddPembimbingState> {
  final PembimbingRemoteDatasources datasource;
  AddPembimbingBloc(this.datasource) : super(const _Initial()) {
    on<_AddPembimbing>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.addPembimbing(
        event.name,
        event.email,
        event.password,
        event.phone,
      );
      result.fold((error) => emit(_Error(error)), (_) {
        emit(const _Success());
      });
    });
  }
}
