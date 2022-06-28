import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'firebase_messaging_manager_platform_interface.dart';

/// An implementation of [FirebaseMessagingManagerPlatform] that uses method channels.
class MethodChannelFirebaseMessagingManager extends FirebaseMessagingManagerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('firebase_messaging_manager');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
