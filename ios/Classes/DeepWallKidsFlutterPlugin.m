#import "DeepWallKidsFlutterPlugin.h"
#if __has_include(<deepwallkids_flutter_plugin/deepwallkids_flutter_plugin-Swift.h>)
#import <deepwallkids_flutter_plugin/deepwallkids_flutter_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "deepwallkids_flutter_plugin-Swift.h"
#endif

@implementation DeepWallKidsFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDeepWallKidsFlutterPlugin registerWithRegistrar:registrar];
}
@end
