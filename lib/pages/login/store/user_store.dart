// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';
import 'package:flutter_aplication01/data/http/exceptions.dart';
import 'package:flutter_aplication01/data/local/local_storage.dart';
import 'package:flutter_aplication01/data/models/user_model.dart';
import 'package:flutter_aplication01/data/repositories/user_repositories.dart';

class UserStore {
  final UserRepository repository;
  final ValueNotifier<bool> isLoading = ValueNotifier(false);
  final ValueNotifier<List<UserModel>> state = ValueNotifier([]);
  final ValueNotifier<UserModel?> currentUser = ValueNotifier(null);
  final ValueNotifier<String> error = ValueNotifier("");

  UserStore({required this.repository});

  Future getUser() async {
    isLoading.value = true;
    try {
      final result = await repository.get();
      state.value = result;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;
    error.value = '';
    try {
      final Map<String, dynamic> data = {'email': email, 'password': password};

      final user = await repository.login(data);

      if (user.token.isNotEmpty) {
        LocalStorage.saveString('token', user.token);
      }
      currentUser.value = user;
      return user;
    } on NotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }

    return null;
  }
}
