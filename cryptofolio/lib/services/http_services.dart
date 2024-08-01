import 'package:cryptofolio/consts.dart';
import 'package:dio/dio.dart';

class HttpServices {
  final Dio _dio = Dio();
  HttpServices() {
    _configureDio();
  }

  void _configureDio() {
    _dio.options = BaseOptions(
      baseUrl: "https://api.cryptorank.io/v1/",
      queryParameters: {
        "api_key": CRYPRO_RANK_APIKEY,
      },
    );
  }

  Future<dynamic> get(String path) async {
    try {
      Response response = await _dio.get(path);
      return response.data;
    } catch (e) {
      print(e);
    }
  }
}
