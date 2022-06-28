import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_messaging_manager/firebase_messaging_manager.dart';
import 'package:firebase_messaging_manager/firebase_messaging_manager_platform_interface.dart';
import 'package:firebase_messaging_manager/firebase_messaging_manager_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFirebaseMessagingManagerPlatform 
    with MockPlatformInterfaceMixin
    implements FirebaseMessagingManagerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FirebaseMessagingManagerPlatform initialPlatform = FirebaseMessagingManagerPlatform.instance;

  test('$MethodChannelFirebaseMessagingManager is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFirebaseMessagingManager>());
  });
}
