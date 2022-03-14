import 'package:dio/dio.dart';
import 'package:universal_platform/universal_platform.dart';

Future<void> prefetchToMemory(List<String> filePaths) async {
  if (UniversalPlatform.isWeb) {
    for (final path in filePaths) {
      await Dio().get('assets/$path');
    }
  }
  return;
}
