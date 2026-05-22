import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aplication01/data/http/http_client.dart';
import 'package:flutter_aplication01/pages/home/home_page.dart';
import 'package:flutter_aplication01/pages/login/login.dart';
import 'package:flutter_aplication01/pages/splace_screen.dart';
import 'package:provider/provider.dart';

class AppWiget extends StatelessWidget {
  const AppWiget({super.key});

  @override
  Widget build(BuildContext context) {
    //fazer requisições http
    final dio = Dio();

    return MultiProvider(
      providers: [
        Provider<Dio>.value(value: dio),
        ProxyProvider<Dio, DioClient>(
          update: (context, dio, dioClient) => DioClient(dio),
        ),
      ],
      child: MaterialApp(
        title: 'consumo em api',
        debugShowCheckedModeBanner: false,
        initialRoute: '/screen',
        routes: {
          '/login': (context) => Login(),
          '/screen': (context) => SplasheScreen(),
          '/home': (context) => HomePage(),
        },
      ),
    );
  }
}
