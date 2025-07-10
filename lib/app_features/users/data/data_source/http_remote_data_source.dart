import 'dart:convert';

import 'package:tafeel_task/app_features/users/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:tafeel_task/core/error/exception.dart';

abstract class HttpRemoteDataSource {
  Future<UserModel> getUsers(int page);

  Future<UserDetailsModel> getUserDetails(int userId);
}

class HttpRemoteDataSourceImpl implements HttpRemoteDataSource {
  final http.Client httpClient;

  HttpRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<UserDetailsModel> getUserDetails(int userId) async {
    final response = await httpClient
        .get(Uri.parse('https://reqres.in/api/users/$userId'), headers: {
      'Content-Type': 'application/json',
      'x-api-key': "reqres-free-v1"
    });
    if (response.statusCode == 200) {
      // return UserDetailsModel.fromJson(json.decode(response.body));
      return UserDetailsModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> getUsers(int page) async {
    final url = Uri.parse('https://reqres.in/api/users')
        .replace(queryParameters: {'page': page.toString()});
    final response = await httpClient.get(
        url.replace(queryParameters: {
          'page': page.toString(),
        }),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': "reqres-free-v1"
        });
    print('🌍 Fetching users from: $url'); // ✅ print the full URL
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
