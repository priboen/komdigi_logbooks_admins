import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:komdigi_logbooks_admins/core/constants/variables.dart';
import 'package:komdigi_logbooks_admins/data/datasources/auth_local_datasources.dart';
import 'package:komdigi_logbooks_admins/data/model/responses/admin_register_response_model.dart';
import 'package:komdigi_logbooks_admins/data/model/responses/auth_response_model.dart';
import 'package:komdigi_logbooks_admins/data/model/responses/update_response_model.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final url = Uri.parse('${Variables.baseUrl}/api/login');
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(
        {
          'email': email,
          'password': password,
        },
      ),
    );
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

  Future<Either<String, AdminRegisterResponseModel>> registerAdmin(
    String name,
    String email,
    String password,
  ) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };
    final url = Uri.parse('${Variables.baseUrl}/api/admin/register');
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(
        {
          'name': name,
          'email': email,
          'password': password,
        },
      ),
    );
    if (response.statusCode == 200) {
      return Right(AdminRegisterResponseModel.fromJson(response.body));
    } else {
      return Left(jsonDecode(response.body)['message']);
    }
  }

  Future<Either<String, UpdateProfileResponseModel>> updateProfile(
    int? id,
    String name,
    String email,
    String password,
    String phone,
    XFile? photo,
  ) async {
    try {
      final authData = await AuthLocalDatasource().getAuthData();
      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      };
      final url = Uri.parse('${Variables.baseUrl}/api/user/update/$id');
      final request = http.MultipartRequest('POST', url)
        ..headers.addAll(headers)
        ..fields['name'] = name
        ..fields['email'] = email
        ..fields['password'] = password
        ..fields['phone'] = phone;
      if (photo != null) {
        request.files.add(
          await http.MultipartFile.fromPath('photo', photo.path),
        );
      }
      final response = await request.send();
      final body = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        return Right(UpdateProfileResponseModel.fromJson(body));
      } else {
        return Left(body);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
