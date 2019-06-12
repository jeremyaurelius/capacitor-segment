import Foundation
import Capacitor
import Analytics

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitor.ionicframework.com/docs/plugins/ios
 */
@objc(SegmentPlugin)
public class SegmentPlugin: CAPPlugin {
    
    var key: String?;
    
    override init(bridge: CAPBridge!, pluginId: String!, pluginName: String!) {
        #if DEBUG
            print("[Segment] ▶️ Segment plugin initialised: " + pluginId + " " + pluginName)
        #endif
        super.init(bridge: bridge, pluginId: pluginId, pluginName: pluginName)
    }

    @objc func setUp(_ call: CAPPluginCall) {
        if (self.key != nil) {
            call.error("segment already set up")
            return;
        }
        let key = call.getString("key")
        let useLocationServices = call.getBool("useLocationServices") ?? false;
        let trackLifecycle = call.getBool("trackLifecycle") ?? false;

        if (key == nil) {
            call.error("segment key not specified")
            return;
        } else {
            #if DEBUG
            print("[Segment] 🔑 Key: " + key! + ". 🌏 Use location: " + useLocationServices.description + ". ♼ Track lifecycle: " + trackLifecycle.description + ".")
            #endif
            self.key = key;
            
            let config: SEGAnalyticsConfiguration = SEGAnalyticsConfiguration.init(writeKey: key!)
            config.shouldUseLocationServices = useLocationServices;
            config.trackApplicationLifecycleEvents = trackLifecycle;
            
            SEGAnalytics.setup(with: config)
            
            call.success([:])
        }
    }
    
    @objc func identify(_ call: CAPPluginCall) {
        if (self.key == nil) {
            call.error("segment not set up")
            return;
        }
        let userID = call.getString("userID")
        if (userID == nil) {
            call.error("no user ID specified")
            return;
        }
        
        let traits: Dictionary = call.getObject("traits") ?? [:];

        #if DEBUG
            print("[Segment] 👱‍♂️ Identify: " + userID! + ". Traits " + traits.description)
        #endif
        
        SEGAnalytics.shared().identify(userID!, traits: traits)
        
        call.success([:])
    }
    
    @objc func track(_ call: CAPPluginCall) {
        if (self.key == nil) {
            call.error("segment not set up")
            return;
        }
        let eventName = call.getString("eventName")
        if (eventName == nil) {
            call.error("no event name specified")
            return;
        }
        
        let properties: Dictionary = call.getObject("properties") ?? [:];
        let options: Dictionary = call.getObject("options") ?? [:];
        
        #if DEBUG
        print("[Segment] 🛤 Track: " + eventName! + ". 📊 Properties: " + properties.description + ". ⚙️ Options: " + options.description)
        #endif
        
        SEGAnalytics.shared().track(eventName!, properties: properties, options: options)
        
        call.success([:])
    }
    
    @objc func reset(_ call: CAPPluginCall) {
        if (self.key == nil) {
            call.error("segment not set up")
            return;
        }
        #if DEBUG
            print("[Segment] 📄 Reset")
        #endif
        
        SEGAnalytics.shared().reset()
        call.success([:])
    }
}
