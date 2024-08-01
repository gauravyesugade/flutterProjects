import 'package:cryptofolio/models/coin_data.dart';
import 'package:cryptofolio/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.coin});
  final CoinData coin;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _buildUI(context),
    );
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.02,
        ),
        child: Column(
          children: [
            _assetPrice(context),
            const SizedBox(height: 10),
            _assetInfo(context)
          ],
        ),
      ),
    );
  }

  Widget _assetPrice(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.1,
      child: Row(
        children: [
          Image.network(
            getCryptoImageURL(coin.name!),
            width: 55,
          ),
          const SizedBox(width: 8),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "\$ ${coin.values?.uSD?.price?.toStringAsFixed(2)}\n",
                  style: const TextStyle(fontSize: 25),
                ),
                TextSpan(
                  text:
                      " ${coin.values?.uSD?.percentChange24h?.toStringAsFixed(2)} %",
                  style: TextStyle(
                      fontSize: 15,
                      color: coin.values!.uSD!.percentChange24h! > 0
                          ? Colors.green
                          : Colors.red),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _assetInfo(BuildContext context) {
    return Expanded(
      child: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.9,
        ),
        children: [
          _infoCard("Circulating Supply", coin.circulatingSupply.toString()),
          _infoCard("Maximum Supply", coin.maxSupply.toString()),
          _infoCard("Total Supply", coin.totalSupply.toString()),
        ],
      ),
    );
  }

  Widget _infoCard(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      centerTitle: true,
      title: Text(coin.name!),
    );
  }
}
