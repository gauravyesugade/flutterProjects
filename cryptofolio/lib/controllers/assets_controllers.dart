import 'dart:convert';

import 'package:cryptofolio/models/api_response.dart';
import 'package:cryptofolio/models/coin_data.dart';
import 'package:cryptofolio/models/tracked_asset.dart';
import 'package:cryptofolio/services/http_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AssetsController extends GetxController {
  RxList<TrackedAsset> trackedAsset = <TrackedAsset>[].obs;
  RxBool loading = false.obs;
  RxList<CoinData> coinData = <CoinData>[].obs;
  @override
  void onInit() {
    super.onInit();
    _getAssets();
    _loadTrackedAssetsFromStorage();
  }

  Future<void> _getAssets() async {
    loading.value = true;
    HttpServices httpServices = Get.find();
    var responceData = await httpServices.get("currencies");
    CurrenciesListAPIResponse currenciesListAPIResponse =
        CurrenciesListAPIResponse.fromJson(responceData);
    coinData.value = currenciesListAPIResponse.data ?? [];
    loading.value = false;
  }

  void addTrackedAsset(String name, double amount) async {
    trackedAsset.add(TrackedAsset(name: name, amount: amount));
    List<String> data = trackedAsset.map((asset) => jsonEncode(asset)).toList();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList("tracked_assets", data);
  }

  void _loadTrackedAssetsFromStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList("tracked_assets");
    if (data != null) {
      trackedAsset.value =
          data.map((e) => TrackedAsset.fromJson(jsonDecode(e))).toList();
    }
  }

  double getPortfolioValue() {
    if (coinData.isEmpty) {
      return 0;
    }
    if (trackedAsset.isEmpty) {
      return 0;
    }
    double value = 0;
    for (TrackedAsset asset in trackedAsset) {
      value += getAssetPrice(asset.name!) * asset.amount!;
    }
    return value;
  }

  double getAssetPrice(String name) {
    CoinData? data = getCoinData(name);
    return data?.values?.uSD?.price?.toDouble() ?? 0;
  }

  CoinData? getCoinData(String name) {
    return coinData.firstWhereOrNull((e) => e.name == name);
  }
}
