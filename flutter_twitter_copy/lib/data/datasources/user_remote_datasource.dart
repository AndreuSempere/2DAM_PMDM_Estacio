import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_twitter_copy/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserRemoteDatasource {
  final String _baseUrl = dotenv.env['API_URL'] ?? 'http://localhost:3000';

  UserRemoteDatasource();

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error en el login: ${response.body}');
    }
  }

  Future<List<UserModel>> getUsers() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data.values
          .map((userJson) =>
              UserModel.fromJson(userJson as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Fallo al obtener todos los users: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getUserInfo(String userId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/users/$userId'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return responseBody;
    } else {
      throw Exception(
          'Fallo al obtener la información del usuario: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> updateUser(
      String userId, String? username, String? avatar) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/users/$userId/update'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': username, 'avatar': avatar}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Fallo al actualizar la información del usuario: ${response.body}');
    }
  }

  Future<void> followUser(String userToFollow, String userId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/users/$userToFollow/follow'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'followerId': userId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed al crear el tweet: ${response.body}');
    }
  }
}
