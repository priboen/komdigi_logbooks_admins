part of 'register_admin_bloc.dart';

@freezed
class RegisterAdminState with _$RegisterAdminState {
  const factory RegisterAdminState.initial() = _Initial;
  const factory RegisterAdminState.loading() = _Loading;
  const factory RegisterAdminState.success(AdminRegisterResponseModel admin) = _Success;
  const factory RegisterAdminState.error(String error) = _Error;
}
