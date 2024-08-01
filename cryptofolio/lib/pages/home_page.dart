import 'package:cryptofolio/controllers/assets_controllers.dart';
import 'package:cryptofolio/models/tracked_asset.dart';
import 'package:cryptofolio/pages/details_page.dart';
import 'package:cryptofolio/utils.dart';
import 'package:cryptofolio/widgets/add_assets_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AssetsController assetsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(context),
      body: _buildUI(context),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: const CircleAvatar(
        backgroundImage: NetworkImage(
          "https://i.pravatar.cc/150?img=3",
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              Get.dialog(AddAssetsDialog());
            },
            icon: const Icon(Icons.add))
      ],
    );
  }

  Widget _buildUI(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [_portfolioValue(context), _trackedAssetsList(context)],
        ),
      ),
    );
  }

  Widget _portfolioValue(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.03,
      ),
      child: Center(
        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            children: [
              const TextSpan(
                text: "\$",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text:
                    "${assetsController.getPortfolioValue().toStringAsFixed(2)}\n",
                style: const TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const TextSpan(
                  text: "Portfolio value",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w200))
            ],
          ),
        ),
      ),
    );
  }

  Widget _trackedAssetsList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width * 0.03),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.05,
            child: const Text(
              "Portfolio",
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: Colors.black38),
            ),
          ),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.65,
            width: MediaQuery.sizeOf(context).width,
            child: ListView.builder(
              itemBuilder: (context, index) {
                TrackedAsset trackedAsset =
                    assetsController.trackedAsset[index];
                return ListTile(
                  leading: Image.network(
                    getCryptoImageURL(
                      trackedAsset.name!,
                    ),
                    width: 40,
                  ),
                  title: Text(
                    trackedAsset.name!,
                  ),
                  trailing: Text(
                    trackedAsset.amount.toString(),
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  subtitle: Text(
                    "USD: ${assetsController.getAssetPrice(trackedAsset.name!).toStringAsFixed(2)}",
                  ),
                  onTap: () {
                    Get.to(() {
                      return DetailsPage(
                          coin: assetsController
                              .getCoinData(trackedAsset.name!)!);
                    });
                  },
                );
              },
              itemCount: assetsController.trackedAsset.length,
            ),
          )
        ],
      ),
    );
  }
}
