import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_messaging_manager/firebase_messaging_manager_method_channel.dart';

void main() {
  MethodChannelFirebaseMessagingManager platform = MethodChannelFirebaseMessagingManager();
  const MethodChannel channel = MethodChannel('firebase_messaging_manager');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
