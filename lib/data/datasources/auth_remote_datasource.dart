import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:komdigi_logbooks_admins/core/constants/variables.dart';
import 'package:komdigi_logbooks_admins/data/datasources/auth_local_datasources.dart';
import 'package:komdigi_logbooks_admins/data/model/responses/auth_response_model.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    final url = Uri.parse('${Variables.baseUrl}/api/login');
    final response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    }, body: {
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/logout');
    final response = await http.post(url, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}'
    });
    if (response.statusCode == 200) {
      await AuthLocalDatasource().removeAuthData();
      return const Right('Logout success');
    } else {
      return const Left('Failed to logout');
    }
  }
}
