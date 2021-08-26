#import "VerticalScrollableTabviewPlugin.h"
#if __has_include(<vertical_scrollable_tabview/vertical_scrollable_tabview-Swift.h>)
#import <vertical_scrollable_tabview/vertical_scrollable_tabview-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "vertical_scrollable_tabview-Swift.h"
#endif

@implementation VerticalScrollableTabviewPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftVerticalScrollableTabviewPlugin registerWithRegistrar:registrar];
}
@end
