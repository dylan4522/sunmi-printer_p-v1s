#import "SunmiPlugin.h"
#import <sunmi/sunmi-Swift.h>

@implementation SunmiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftSunmiPlugin registerWithRegistrar:registrar];
}
@end
