// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_aplication01/data/http/endpoints.dart';
import 'package:flutter_aplication01/data/http/http_client.dart';
import 'package:flutter_aplication01/data/local/local_storage.dart';
import 'package:flutter_aplication01/data/models/user_model.dart';

class UserRepository {
  //fazendo comunicação com api

  final IHttpClient client;
  UserRepository(this.client);

  Future<UserModel> login(Map<String, dynamic> data) async {
    final response = await client.post(
      url: '${Endpoints.baseUrl}/login',
      data: data,
    );

    if (response.statusCode == 200) {
      final body = response.data;

      if (body is Map<String, dynamic>) {
        UserModel user = UserModel.fromMap(body);
        return user;
      } else {
        throw FormatException('Resposta Inesperada do servidor');
      }
    } else if (response.statusCode == 401) {
      throw Exception('Credenciais inválidas');
    } else if (response.statusCode == 404) {
      throw Exception('Endpoint não encontrado');
    } else {
      throw Exception('Erro desconhecido: ${response.statusCode}');
    }
    // return response['token'] as String;
  }

  Future<List<UserModel>> get() async {
    final token = await LocalStorage.getString('token');

    final response = await client.get(
      url: '${Endpoints.baseUrl}/users',
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<UserModel> users = [];
      final body = response.data;

      body.map((item) {
        final UserModel user = UserModel.fromMap(item);
        users.add(user);
      }).toList();

      return users;
    } else if (response.statusCode == 401) {
      throw Exception('Token inválido ou expirado');
    } else if (response.statusCode == 404) {
      throw Exception('Endpoint não encontrado');
    } else {
      throw Exception('Erro desconhecido: ${response.statusCode}');
    }
  }
}
