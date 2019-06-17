package com.jairemix.capacitor.segment;

import com.getcapacitor.JSObject;
import com.getcapacitor.NativePlugin;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import android.util.Log;

@NativePlugin()
public class SegmentPlugin extends Plugin {

    private static final String PLUGIN_TAG = "[CapacitorSegment]";
    private String key;

    public void load() {
        super.load();
        Log.d(PLUGIN_TAG, "capacitor segment loaded");
    }

    @PluginMethod()
    public void setUp(PluginCall call) {

        if (this.key != null) {
            call.error("[SET_UP] DUPE_CALL");
            return;
        }

        String key = call.getString("key");

        if (key == null) {
            call.error("[SET_UP] NO_KEY");
            return;
        }

        Log.d(PLUGIN_TAG, "setUp() key: " + key);

        this.key = key;

        call.success();
    }

    @PluginMethod()
    public void identify(PluginCall call) {

        if (this.key == null) {
            call.error("[IDENTIFY] NOT_SET_UP");
            return;
        }

        String userID = call.getString("userID");

        if (userID == null) {
            call.error("[IDENTIFY] NO_USER_ID");
            return;
        }

        JSObject traits = call.getObject("traits");
        if (traits == null) {
            traits = new JSObject();
        }

        Log.d(PLUGIN_TAG, "identify() userID: " + userID + ". traits: " + traits.toString());

        call.success();
    }

    @PluginMethod()
    public void track(PluginCall call) {

        if (this.key == null) {
            call.error("[TRACK] NOT_SET_UP");
            return;
        }

        String eventName = call.getString("eventName");

        if (eventName == null) {
            call.error("[TRACK] NO_EVENT_NAME");
            return;
        }

        JSObject properties = call.getObject("properties");
        JSObject options = call.getObject("options");
        if (properties == null) {
            properties = new JSObject();
        }
        if (options == null) {
            options = new JSObject();
        }


        Log.d(PLUGIN_TAG, "track() eventName: " + eventName + ". properties: " + properties.toString() + ". options: " + options.toString());

        call.success();
    }

    @PluginMethod()
    public void reset(PluginCall call) {
        if (this.key == null) {
            call.error("[RESET] NOT_SET_UP");
            return;
        }

        call.success();
    }
}
