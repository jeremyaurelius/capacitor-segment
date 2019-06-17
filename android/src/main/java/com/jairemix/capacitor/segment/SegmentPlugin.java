package com.jairemix.capacitor.segment;

import com.getcapacitor.JSObject;
import com.getcapacitor.NativePlugin;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import android.util.Log;

@NativePlugin()
public class SegmentPlugin extends Plugin {

    private static final String PLUGIN_TAG = "[JairemixCapacitorSegment]";

    public void load() {
        super.load();
        Log.d(PLUGIN_TAG, "capacitor segment loaded");
    }

    // @PluginMethod()
    // public void echo(PluginCall call) {
    //     String value = call.getString("value");

    //     JSObject ret = new JSObject();
    //     ret.put("value", value);
    //     call.success(ret);
    // }
}
