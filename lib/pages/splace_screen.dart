import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplasheScreen extends StatefulWidget {
  const SplasheScreen({super.key});

  @override
  State<SplasheScreen> createState() => _SplasheScreenState();
}

class _SplasheScreenState extends State<SplasheScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Lottie.network(
              'https://lottie.host/9491913a-4f2b-4061-82ea-59a30834e94d/ZOJNychsaM.json',
              width: 400,
              height: 200,
              fit: BoxFit.contain,
            ),
            Text(
              'carregando...',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Lottie.network(
              'https://lottie.host/69af3ca8-b264-46a4-8b27-8a0d760ea143/L91HUaAAiw.json',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
