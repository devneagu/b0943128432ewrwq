import 'package:crypto_stats/crypto_stats/bloc/crypto_stats_bloc.dart';
import 'package:crypto_stats/generated/assets.gen.dart';
import 'package:crypto_stats/l10n/l10n.dart';
import 'package:crypto_stats_repository/crypto_stats_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoStatsPage extends StatelessWidget {
  const CryptoStatsPage({Key? key}) : super(key: key);

  static const routeName = 'CryptoStatsPage';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const CryptoStatsPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CryptoStatsBloc(
        cryptoStatsRepository: context.read<CryptoStatsRepository>(),
      )..add(const CryptoStatsSocketConnected()),
      child: const CryptoStatsView(),
    );
  }
}

class CryptoStatsView extends StatelessWidget {
  const CryptoStatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          SizedBox(height: 20),
          CustomAppBar(),
          SizedBox(height: 20),
          BalanceCard(),
          SizedBox(height: 20),
          MyPortfolio(),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.welcome,
                  style: const TextStyle(fontSize: 16),
                ),
                const Text(
                  'Elian Ortega',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            CircleAvatar(
              backgroundImage: Assets.images.avatar,
              radius: 25,
            )
          ],
        ),
      ),
    );
  }
}

class BalanceCard extends StatelessWidget {
  const BalanceCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF516EFB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.balance,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const Text(
            r'$450,933',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.monthlyProfit,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    r'$12,484',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Card(
                elevation: 0,
                shape: const StadiumBorder(),
                color: Colors.white.withOpacity(.2),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 3,
                  ),
                  child: Row(
                    children: const [
                      Icon(
                        Icons.arrow_drop_up_rounded,
                        color: Colors.greenAccent,
                      ),
                      Text(
                        '10 % ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class MyPortfolio extends StatelessWidget {
  const MyPortfolio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            l10n.livePrices,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        const PortfolioList(),
      ],
    );
  }
}

class PortfolioList extends StatelessWidget {
  const PortfolioList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height / 3,
      child: BlocBuilder<CryptoStatsBloc, CryptoStatsState>(
        builder: (context, state) {
          if (state is CryptoStatsData) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 20),
              scrollDirection: Axis.horizontal,
              itemCount: state.stats.length,
              itemBuilder: (context, index) => AspectRatio(
                aspectRatio: 1.3 / 1,
                child: BlocSelector<CryptoStatsBloc, CryptoStatsState,
                    TradeReport>(
                  selector: (state) =>
                      (state as CryptoStatsData).stats.values.toList()[index],
                  builder: (context, tradeReport) => CoinCard(
                    tradeReport: tradeReport,
                  ),
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class CoinCard extends StatelessWidget {
  CoinCard({
    Key? key,
    required this.tradeReport,
  }) : super(key: key);

  final TradeReport tradeReport;

  final Map<CryptoCurrency, ImageProvider> crytoImage = {
    CryptoCurrency.btc: Assets.images.btc,
    CryptoCurrency.eth: Assets.images.eth,
    CryptoCurrency.ada: Assets.images.ada,
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.only(left: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image(
                  image: crytoImage[tradeReport.crytpType()]!,
                  width: 50,
                ),
                const SizedBox(width: 20),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: tradeReport.symbolId.split('_')[2],
                      ),
                      const TextSpan(
                        text: '/USD',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const Spacer(),
            Text(
              tradeReport.price.toStringAsFixed(4),
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            Text(
              tradeReport.takerSide,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
