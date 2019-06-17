# capacitor-segment
- Capacitor wrapper plugin for Segment analytics mobile SDK.
- Only implemented on iOS and Android (not for PWA)

## Installation

#### yarn
```
$ yarn add @jairemix/capacitor-segment
$ yarn cap sync
```

#### npm
```
$ npm install @jairemix/capacitor-segment
$ npx cap sync
```
### Android only
After installing and syncing the Capacitor plugin, remember to add it to `MainActivity.java`
```java
// Other Imports
import com.jairemix.capacitor.segment.SegmentPlugin;

public class MainActivity extends BridgeActivity {

  @Override
  public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    // Initializes the Bridge
    this.init(savedInstanceState, new ArrayList<Class<? extends Plugin>>() {{
      add(SegmentPlugin.class);
      // Additional plugins you've installed go here
    }});
  }
  
}
```

## Example
```ts
import { segmentPlugin } from '@jairemix/capacitor-segment';

async function test() {

  await segmentPlugin.setUp({
    key: 'test_key',
    trackLifecycle: true, // optional; defaults to false
  });

  await segmentPlugin.identify({
    userID: 'jake_peralta',
    traits: { // optional
      noice: true,
      smort: true,
      toit: true,
    },
  });

  await segmentPlugin.track({
    eventName: 'item_ordered',
    properties: { // optional
      itemID: 'orange_soda',
    },
  });

  await segmentPlugin.reset(); // on logout
}
```

## Methods

#### setUp (options: { key: string, trackLifecycle = false })
Passes segment key to Segment SDK

#### identify (options: { userID: string, traits? })
Sets userID in Segment SDK

#### track (options: { eventName: string, properties?, options? })
Tracks a Segment event

#### reset ()
Clears previously set userID
