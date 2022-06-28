import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'firebase_messaging_manager_method_channel.dart';

abstract class FirebaseMessagingManagerPlatform extends PlatformInterface {
  /// Constructs a FirebaseMessagingManagerPlatform.
  FirebaseMessagingManagerPlatform() : super(token: _token);

  static final Object _token = Object();

  static FirebaseMessagingManagerPlatform _instance = MethodChannelFirebaseMessagingManager();

  /// The default instance of [FirebaseMessagingManagerPlatform] to use.
  ///
  /// Defaults to [MethodChannelFirebaseMessagingManager].
  static FirebaseMessagingManagerPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FirebaseMessagingManagerPlatform] when
  /// they register themselves.
  static set instance(FirebaseMessagingManagerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
