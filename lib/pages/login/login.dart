import 'package:flutter/material.dart';
import 'package:flutter_aplication01/data/http/http_client.dart';
import 'package:flutter_aplication01/data/repositories/user_repositories.dart';
import 'package:flutter_aplication01/pages/login/store/user_store.dart';
import 'package:flutter_aplication01/widget/custom_edit.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController();
  final controllerSenha = TextEditingController();
  bool clicou = false;

  @override
  Widget build(BuildContext context) {
    final dioClient = Provider.of<DioClient>(context);
    UserStore store = UserStore(repository: UserRepository(client: dioClient));

    Future<void> login() async {
      if (_formKey.currentState!.validate()) {
        final user = await store.login(
          email: controllerEmail.text,
          password: controllerSenha.text,
        );
        if (!mounted) return;
        if (user != null) {
          Navigator.pushReplacementNamed(context, '/home', arguments: user);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 216, 163, 3),
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: CustomEdit(
                  label: 'Usuários',
                  icone: Icon(Icons.person),
                  controller: controllerEmail,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "por favor preencha o campo email";
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: CustomEdit(
                  label: 'Senha',
                  icone: Icon(Icons.lock),
                  isObscure: true,
                  controller: controllerSenha,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "por favor preencher o campo senha";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  width: double.infinity,
                  height: 40,

                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        login();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
                      "Entrar",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),

              ValueListenableBuilder(
                valueListenable: store.error,
                builder: (context, errorMessage, child) {
                  if (errorMessage.isEmpty) {
                    return SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                },
              ),
              ValueListenableBuilder(
                valueListenable: store.isLoading,
                builder: (context, isLoading, child) {
                  if (!isLoading) {
                    return SizedBox.shrink();
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Lottie.asset(
                      'assets/animacoes/loading.json',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
