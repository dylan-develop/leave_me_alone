import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CacheHelper {
  static Future<void> prefetchToMemory(List<String> filePaths) async {
    if (kIsWeb) {
      for (final path in filePaths) {
        Dio().get('assets/$path');
      }
    }
    return;
  }
}
