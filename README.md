# capacitor-segment
- Capacitor wrapper plugin for Segment analytics mobile SDK.
- Currently only implemented on iOS.

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

## Example
```ts
import { segmentPlugin } from '@jairemix/capacitor-segment';

async function test() {

  await segmentPlugin.setUp({
    key: 'test_key',
    useLocationServices: false, // optional; defaults to false
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

#### setUp (options: { key: string, useLocationServices = false, trackLifecycle = false })
Passes segment key to Segment SDK

#### identify (options: { userID: string, traits? })
Sets userID in Segment SDK

#### track (options: { eventName: string, properties?, options? })
Tracks a Segment event

#### reset ()
Clears previously set userID
