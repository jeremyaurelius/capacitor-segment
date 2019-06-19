#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(SegmentPlugin, "SegmentPlugin",
           CAP_PLUGIN_METHOD(setUp, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(identify, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(track, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(reset, CAPPluginReturnPromise);
)
