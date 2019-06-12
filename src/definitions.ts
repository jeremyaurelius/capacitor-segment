declare module '@capacitor/core' {
  interface PluginRegistry {
    SegmentPlugin: SegmentPlugin;
  }
}

export interface SegmentPlugin {
  setUp(options: {
    key: string,
    useLocationServices?: boolean,
    trackLifecycle?: boolean,
  }): Promise<{}>;

  identify(options: {
    userID: string,
    traits?: { [K: string]: any },
  }): Promise<{}>;

  track(options: {
    eventName: string,
    properties?: { [K: string]: any },
    options?: { [K: string]: any},
  }): Promise<{}>;

  reset(): Promise<{}>;
}

export interface SegmentPluginError {
  message: string;
  code:
    '[SET_UP] DUPE_CALL' |
    '[SET_UP] NO_KEY' |
    '[IDENTIFY] NOT_SET_UP' |
    '[IDENTIFY] NO_USER_ID' |
    '[TRACK] NOT_SET_UP' |
    '[TRACK] NO_EVENT_NAME' |
    '[RESET] NOT_SET_UP';
}
