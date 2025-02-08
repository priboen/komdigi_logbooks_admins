part of 'register_admin_bloc.dart';

@freezed
class RegisterAdminEvent with _$RegisterAdminEvent {
  const factory RegisterAdminEvent.started() = _Started;
  const factory RegisterAdminEvent.registerAdmin({
    required String name,
    required String email,
    required String password,
  }) = _RegisterAdmin;
}