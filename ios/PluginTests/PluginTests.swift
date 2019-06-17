import XCTest
import Capacitor
import Promises

@testable import Plugin

class PluginTests: XCTestCase {
    
  override func setUp() {
      super.setUp()
      // Put setup code here. This method is called before the invocation of each test method in the class.
  }
    
  override func tearDown() {
      // Put teardown code here. This method is called after the invocation of each test method in the class.
      super.tearDown()
  }
  
  func testSetUp() {
    
    let plugin = SegmentPlugin()
    let expectation = XCTestExpectation(description: "[SET_UP]");
    
    Promise(()).then({

      // "[SET_UP] NO_KEY"

      return Promise<Void>(on: .main) { (fulfill, reject) in
        let call = CAPPluginCall(callbackId: "test", options: [:], success: { (result, call) in
          XCTFail("🤦‍♂️ Success callback should not have been called with empty key")
          fulfill(());
        }, error: { (err: CAPPluginCallError?) in
          XCTAssertEqual(err!.message!, "[SET_UP] NO_KEY");
          fulfill(());
        });
        plugin.setUp(call!);
      };

    }).then({

      // "[SET_UP] SUCCESS"

      return Promise<Void>(on: .main) { (fulfill, reject) in
        let call = CAPPluginCall(callbackId: "test", options: [
          "key": "test_segment_key"
        ], success: { (result, call) in
          XCTAssertEqual(result!.data == nil, true);
          fulfill(());
        }, error: { (err: CAPPluginCallError?) in
          XCTFail("🤦‍♂️ Error callback should not have been called")
          fulfill(());
        });
        plugin.setUp(call!);
      };

    }).then({

      // "[SET_UP] DUPE_CALL"

      return Promise<Void>(on: .main) { (fulfill, reject) in
        let call = CAPPluginCall(callbackId: "test", options: [
          "key": "test_segment_key"
        ], success: { (result, call) in
          XCTFail("🤦‍♂️ Success callback should not have been called")
          fulfill(());
        }, error: { (err: CAPPluginCallError?) in
          XCTAssertEqual(err!.message!, "[SET_UP] DUPE_CALL");
          fulfill(());
        });
        plugin.setUp(call!);
      };

    }).then({
      expectation.fulfill();
    });

    self.wait(for: [expectation], timeout: 1);
    
    // TODO: test lifecycle

  }
  
  
  func testIdentify() {

    let plugin = SegmentPlugin();
    let expectation = XCTestExpectation(description: "[IDENTIFY]");

    Promise(()).then({

      // [IDENTIFY] NOT_SET_UP

      return Promise<Void>(on: .main) { (fulfill, reject) in
        let call = CAPPluginCall(callbackId: "test", options: [:], success: { (result, call) in
          XCTFail("🤦‍♂️ Success callback should not have been called")
          fulfill(());
        }, error: { (err: CAPPluginCallError?) in
          XCTAssertEqual(err!.message!, "[IDENTIFY] NOT_SET_UP");
          fulfill(());
        });
        plugin.identify(call!);
      };

    }).then({

      return self._setUpForTest(plugin: plugin);

    }).then({ () -> Promise<Void> in

      // [IDENTIFY] NO_USER_ID
      
      return Promise<Void>(on: .main) { (fulfill, reject) in
        let call = CAPPluginCall(callbackId: "test", options: [:], success: { (result, call) in
          XCTFail("🤦‍♂️ Success callback should not have been called")
          fulfill(());
        }, error: { (err: CAPPluginCallError?) in
          XCTAssertEqual(err!.message!, "[IDENTIFY] NO_USER_ID");
          fulfill(());
        });
        plugin.identify(call!);
      };

    }).then({ () -> Promise<Void> in

      // [IDENTIFY] SUCCESS
      
      return Promise<Void>(on: .main) { (fulfill, reject) in
        let call = CAPPluginCall(callbackId: "test", options: [
          "userID": "jeremy_test_id",
        ], success: { (result, call) in
          fulfill(());
        }, error: { (err: CAPPluginCallError?) in
          XCTFail("🤦‍♂️ Failure callback should not have been called");
          fulfill(());
        });
        plugin.identify(call!);
      };

    }).then({
      expectation.fulfill();
    });
    
    // TODO: TEST TRAITS
    
    self.wait(for: [expectation], timeout: 1);

  }
  
  func testTrack() {
    
    let plugin = SegmentPlugin();
    let expectation = XCTestExpectation(description: "[TRACK]");
    
    Promise(()).then({
      
      // [TRACK] NOT_SET_UP
      
      return Promise<Void>(on: .main) { (fulfill, reject) in
        let call = CAPPluginCall(callbackId: "test", options: [:], success: { (result, call) in
          XCTFail("🤦‍♂️ Success callback should not have been called");
          fulfill(());
        }, error: { (err: CAPPluginCallError?) in
          XCTAssertEqual(err!.message!, "[TRACK] NOT_SET_UP");
          fulfill(());
        });
        plugin.track(call!);
      };
      
    }).then({
      
      return self._setUpForTest(plugin: plugin);
      
    }).then({ () -> Promise<Void> in
      
      // [TRACK] NO_USER_ID
      
      return Promise<Void>(on: .main) { (fulfill, reject) in
        let call = CAPPluginCall(callbackId: "test", options: [:], success: { (result, call) in
          XCTFail("🤦‍♂️ Success callback should not have been called");
          fulfill(());
        }, error: { (err: CAPPluginCallError?) in
          XCTAssertEqual(err!.message!, "[TRACK] NO_EVENT_NAME");
          fulfill(());
        });
        plugin.track(call!);
      };
      
    }).then({ () -> Promise<Void> in
      
      // [TRACK] SUCCESS
      
      return Promise<Void>(on: .main) { (fulfill, reject) in
        let call = CAPPluginCall(callbackId: "test", options: [
          "eventName": "test_event_name",
        ], success: { (result, call) in
          fulfill(());
        }, error: { (err: CAPPluginCallError?) in
          XCTFail("🤦‍♂️ Failure callback should not have been called");
          fulfill(());
        });
        plugin.track(call!);
      };
      
    }).then({
      expectation.fulfill();
    });
    
    // TODO: TEST PROPERTIES, OPTIONS
    
    self.wait(for: [expectation], timeout: 1);
    
  }
  
  func testReset() {
    let plugin = SegmentPlugin();
    let expectation = XCTestExpectation(description: "[TRACK]");
    
    Promise(()).then({
      
      // [RESET] NOT_SET_UP
      
      return Promise<Void>(on: .main) { (fulfill, reject) in
        let call = CAPPluginCall(callbackId: "test", options: [:], success: { (result, call) in
          XCTFail("🤦‍♂️ Success callback should not have been called");
          fulfill(());
        }, error: { (err: CAPPluginCallError?) in
          XCTAssertEqual(err!.message!, "[RESET] NOT_SET_UP");
          fulfill(());
        });
        plugin.reset(call!);
      };
      
    }).then({
      
      return self._setUpForTest(plugin: plugin);
      
    }).then({ () -> Promise<Void> in
      
      // [RESET] SUCCESS
      
      return Promise<Void>(on: .main) { (fulfill, reject) in
        let call = CAPPluginCall(callbackId: "test", options: [:], success: { (result, call) in
          fulfill(());
        }, error: { (err: CAPPluginCallError?) in
          XCTFail("🤦‍♂️ Failure callback should not have been called");
          fulfill(());
        });
        plugin.reset(call!);
      };
      
    }).then({
      expectation.fulfill();
    });
    
    self.wait(for: [expectation], timeout: 1);
  }
  
  private func _setUpForTest(plugin: SegmentPlugin) -> Promise<Void> {
    return Promise<Void>(on: .main) { (fulfill, reject) in
      let call = CAPPluginCall(callbackId: "test", options: [
        "key": "test_segment_key"
      ], success: { (result, call) in
        fulfill(());
      }, error: { (err: CAPPluginCallError?) in
        fulfill(());
      });
      plugin.setUp(call!);
    };
  }
  
}
