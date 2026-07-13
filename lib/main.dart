import 'package:cryptoBazzar/core/di/service_locator.dart';
import 'package:cryptoBazzar/presentation/coin_list/screens/coin_list_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  await setUpLocator();
  runApp(CryptoBazzarApp());
}

class CryptoBazzarApp extends StatelessWidget {
  const CryptoBazzarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Bazzar',
      home: CoinListScreen(),
    );
  }
}
