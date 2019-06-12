import { WebPlugin } from '@capacitor/core';
import { SegmentPlugin } from './definitions';

export class SegmentPluginWeb extends WebPlugin implements SegmentPlugin {
  constructor() {
    super({
      name: 'SegmentPlugin',
      platforms: ['web']
    });
  }

  async setUp(_: {
    key: string,
    useLocationServices?: boolean,
    trackLifecycle?: boolean,
  }): Promise<{}> {
    throw Error('not available on web');
  }

  async identify(_: {
    userID: string,
    traits?: { [K: string]: any },
  }): Promise<{}> {
    throw Error('not available on web');
  }

  async track(_: {
    eventName: string,
    properties?: { [K: string]: any },
    options?: { [K: string]: any },
  }): Promise<{}> {
    throw Error('not available on web');
  }

  async reset(): Promise<{}> {
    throw Error('not available on web');
  }

}

const segmentPluginWeb = new SegmentPluginWeb();

export { segmentPluginWeb };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(segmentPluginWeb);
