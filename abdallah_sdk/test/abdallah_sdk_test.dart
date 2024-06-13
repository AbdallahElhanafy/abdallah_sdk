import 'package:flutter_test/flutter_test.dart';
import 'package:abdallah_sdk/abdallah_sdk.dart';
import 'package:abdallah_sdk/abdallah_sdk_platform_interface.dart';
import 'package:abdallah_sdk/abdallah_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAbdallahSdkPlatform
    with MockPlatformInterfaceMixin
    implements AbdallahSdkPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AbdallahSdkPlatform initialPlatform = AbdallahSdkPlatform.instance;

  test('$MethodChannelAbdallahSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAbdallahSdk>());
  });

  test('getPlatformVersion', () async {
    AbdallahSdk abdallahSdkPlugin = AbdallahSdk();
    MockAbdallahSdkPlatform fakePlatform = MockAbdallahSdkPlatform();
    AbdallahSdkPlatform.instance = fakePlatform;

    expect(await abdallahSdkPlugin.getPlatformVersion(), '42');
  });
}
