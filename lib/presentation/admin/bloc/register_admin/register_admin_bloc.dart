import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:komdigi_logbooks_admins/data/datasources/auth_remote_datasource.dart';
import 'package:komdigi_logbooks_admins/data/model/responses/admin_register_response_model.dart';

part 'register_admin_event.dart';
part 'register_admin_state.dart';
part 'register_admin_bloc.freezed.dart';

class RegisterAdminBloc extends Bloc<RegisterAdminEvent, RegisterAdminState> {
  final AuthRemoteDatasource authRemoteDatasource;
  RegisterAdminBloc(this.authRemoteDatasource) : super(const _Initial()) {
    on<_RegisterAdmin>((event, emit) async {
      emit(const _Loading());
      final result = await authRemoteDatasource.registerAdmin(
        event.name,
        event.email,
        event.password,
      );
      result.fold(
        (error) => emit(_Error(error)),
        (admin) => emit(_Success(admin)),
      );
    });
  }
}
