#import "FirebaseMessagingManagerPlugin.h"
#if __has_include(<firebase_messaging_manager/firebase_messaging_manager-Swift.h>)
#import <firebase_messaging_manager/firebase_messaging_manager-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "firebase_messaging_manager-Swift.h"
#endif

@implementation FirebaseMessagingManagerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFirebaseMessagingManagerPlugin registerWithRegistrar:registrar];
}
@end
