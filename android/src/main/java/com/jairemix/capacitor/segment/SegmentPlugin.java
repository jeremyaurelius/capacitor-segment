package com.jairemix.capacitor.segment;

import com.getcapacitor.JSObject;
import com.getcapacitor.NativePlugin;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;

import android.content.Context;
import android.util.Log;
import com.segment.analytics.Analytics;
import com.segment.analytics.Analytics.Builder;
import com.segment.analytics.Options;
import com.segment.analytics.Properties;
import com.segment.analytics.Traits;

import org.json.JSONException;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

@NativePlugin()
public class SegmentPlugin extends Plugin {

    private static final String PLUGIN_TAG = "CapacitorSegment";
    private String key;
    private Analytics analytics;

//    public void load() {
//        super.load();
//        Log.d(PLUGIN_TAG, "capacitor segment loaded");
//    }

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

        boolean trackLifecycle = call.getBoolean("trackLifecycle", false);

        Log.d(PLUGIN_TAG, "setUp() key: " + key + ". trackLifecycle: " + trackLifecycle);

        Builder builder = new Analytics.Builder(this.getContext(), key);

        if (trackLifecycle) {
            builder.trackApplicationLifecycleEvents();
        }

        this.analytics = builder.build();
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

        Log.d(PLUGIN_TAG, "identify() userID: " + userID + ". traits: " + traits);

        this.analytics.identify(userID, makeTraitsFromMap(makeMapFromJSON(traits)), null); // currently not supporting options

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

        Log.d(PLUGIN_TAG, "track() properties: " + properties + ". options: " + options);

        this.analytics.track(
                eventName,
                makePropertiesFromMap(makeMapFromJSON(properties)),
                makeOptionsFromJSON(options)
        );

        call.success();
    }

    private Map makeMapFromJSON(JSObject obj) {
        Iterator<String> keys = obj.keys();
        Map map = new HashMap();
        while (keys.hasNext()) {
            String key = keys.next();
            try {
                Object value = obj.get(key);
                map.put(key, value);
            } catch (JSONException e) {
                Log.d(PLUGIN_TAG, "❌ could not get value for key " + key);
            }
        }
        return map;
    }

    private Traits makeTraitsFromMap(Map map) {
        Traits traits = new Traits();
        traits.putAll(map);
        return traits;
    }

    private Properties makePropertiesFromMap(Map map) {
        Properties properties = new Properties();
        properties.putAll(map);
        return properties;
    }

    private Options makeOptionsFromJSON(JSObject obj) {
        Options options = new Options();
        Iterator<String> keys = obj.keys();
        while (keys.hasNext()) {
            String key = keys.next();
            try {
                boolean enabled = obj.getBool(key);
                options.setIntegration(key, enabled);
            } catch (Exception e) {
                Log.d(PLUGIN_TAG, "❌ could not get boolean for key " + key);
            }
        }
        return options;
    }

    @PluginMethod()
    public void reset(PluginCall call) {
        if (this.key == null) {
            call.error("[RESET] NOT_SET_UP");
            return;
        }

        this.analytics.reset();

        call.success();
    }
}
