import 'package:cryptofolio/controllers/assets_controllers.dart';
import 'package:cryptofolio/models/api_response.dart';
import 'package:cryptofolio/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAssetsDialogController extends GetxController {
  RxBool loading = true.obs;
  RxList<String> assets = <String>[].obs;
  RxString selectedAssets = "".obs;
  RxDouble assetValue = 0.0.obs;
  @override
  void onInit() {
    super.onInit();
    _getAssets();
  }

  Future _getAssets() async {
    loading.value = true;
    HttpServices httpServices = Get.find<HttpServices>();
    var responceData = await httpServices.get("currencies");
    CurrenciesListAPIResponse currenciesListAPIResponse =
        CurrenciesListAPIResponse.fromJson(responceData);
    currenciesListAPIResponse.data?.forEach((coin) {
      assets.add(coin.name!);
    });
    selectedAssets.value = assets.first;
    loading.value = false;
  }
}

class AddAssetsDialog extends StatelessWidget {
  final controller = Get.put(
    AddAssetsDialogController(),
  );

  AddAssetsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: Material(
          child: Container(
            height: MediaQuery.sizeOf(context).height * 0.4,
            width: MediaQuery.sizeOf(context).width * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: _buildUI(context),
          ),
        ),
      ),
    );
  }

  Widget _buildUI(BuildContext context) {
    if (controller.loading.isTrue) {
      return const Center(
        child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButton(
              value: controller.selectedAssets.value,
              items: controller.assets.map(
                (asset) {
                  return DropdownMenuItem(
                    value: asset,
                    child: Text(asset),
                  );
                },
              ).toList(),
              onChanged: (value) {
                if (value != null) {
                  controller.selectedAssets.value = value;
                }
              },
            ),
            TextField(
              onChanged: (value) {
                controller.assetValue.value = double.parse(value);
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            MaterialButton(
              onPressed: () {
                AssetsController assetsController = Get.find();
                assetsController.addTrackedAsset(
                    controller.selectedAssets.value,
                    controller.assetValue.value);
                Get.back(closeOverlays: true);
              },
              color: Theme.of(context).colorScheme.primary,
              child: const Text(
                "Add Asset",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      );
    }
  }
}
