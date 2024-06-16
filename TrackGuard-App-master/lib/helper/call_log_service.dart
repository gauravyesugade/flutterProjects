import 'package:flutter/services.dart';

class CallLogService {
  static const MethodChannel _channel = MethodChannel('com.example.call_log');

  static Future<List<Map<String, dynamic>>> getCallLogs() async {
    final List<dynamic> callLogs = await _channel.invokeMethod('getCallLogs');
    return callLogs.cast<Map<String, dynamic>>();
  }
}
