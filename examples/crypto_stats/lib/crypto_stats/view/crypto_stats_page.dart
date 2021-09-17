import 'package:flutter/material.dart';

class CryptoStatsPage extends StatelessWidget {
  const CryptoStatsPage({Key? key}) : super(key: key);

  static const routeName = 'CryptoStatsPage';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const CryptoStatsPage());
  }

  @override
  Widget build(BuildContext context) {
    return const CryptoStatsView();
  }
}

class CryptoStatsView extends StatelessWidget {
  const CryptoStatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [],
      ),
    );
  }
}
