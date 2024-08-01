import 'package:cryptofolio/controllers/assets_controllers.dart';
import 'package:cryptofolio/services/http_services.dart';
import 'package:get/get.dart';

Future<void> registerServices() async {
  Get.put(
    HttpServices(),
  );
}

Future<void> registerController() async {
  Get.put(
    AssetsController(),
  );
}

String getCryptoImageURL(String name) {
  return "https://raw.githubusercontent.com/ErikThiart/cryptocurrency-icons/master/128/${name.toLowerCase()}.png";
}
