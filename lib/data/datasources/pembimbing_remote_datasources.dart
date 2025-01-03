import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:komdigi_logbooks_admins/core/constants/variables.dart';
import 'package:komdigi_logbooks_admins/data/datasources/auth_local_datasources.dart';
import 'package:komdigi_logbooks_admins/data/model/responses/pembimbing_response_model.dart';

class PembimbingRemoteDatasources {
  Future<Either<String, String>> addPembimbing(
    String name,
    String email,
    String password,
    String phone,
  ) async {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final url = Uri.parse('${Variables.baseUrl}/api/supervisor/register');
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(
        {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
        },
      ),
    );
    if (response.statusCode == 200) {
      return Right('Pembimbing berhasil ditambahkan');
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, PembimbingResponseModel>> getPembimbing() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };
    final url = Uri.parse('${Variables.baseUrl}/api/supervisor');
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return Right(PembimbingResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, String>> deletePembimbing(int id) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${authData?.token}',
    };
    final url = Uri.parse('${Variables.baseUrl}/api/supervisor/$id');
    final response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      return const Right('Pembimbing berhasil dihapus');
    } else {
      return Left(response.body);
    }
  }
}
