import '@capacitor/core';

declare module "@capacitor/core" {
  interface PluginRegistry {
    SegmentPlugin: SegmentPlugin;
  }
}

export interface SegmentPlugin {
  setUp(options: { key: string }): Promise<{}>;
}
