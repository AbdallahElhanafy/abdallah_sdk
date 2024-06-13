import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'abdallah_sdk_platform_interface.dart';

/// An implementation of [AbdallahSdkPlatform] that uses method channels.
class MethodChannelAbdallahSdk extends AbdallahSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('abdallah_sdk');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
