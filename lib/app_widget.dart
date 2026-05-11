import 'package:flutter/material.dart';
import 'package:flutter_aplication01/pages/login.dart';
import 'package:flutter_aplication01/pages/splace_screen.dart';

class AppWiget extends StatelessWidget {
  const AppWiget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'consumo em api',
      debugShowCheckedModeBanner: false,
      initialRoute: '/screen',
      routes: {
        '/login': (context) => Login(),
        '/screen': (context) => SplasheScreen(),
      },
    );
  }
}
