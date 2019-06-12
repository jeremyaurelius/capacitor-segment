import XCTest
import Capacitor
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
    

    ({
      let expectation = XCTestExpectation(description: "[SET_UP] NO_KEY");
      let call = CAPPluginCall(callbackId: "test", options: [:], success: { (result, call) in
        XCTFail("🤦‍♂️ Success callback should not have been called with empty key")
        expectation.fulfill()
      }, error: { (err: CAPPluginCallError?) in
        XCTAssertEqual(err!.message, "segment key not specified");
        XCTAssertEqual(err!.data!["code"]! as? String, "[SET_UP] NO_KEY");
        //      print("👎 err message: " + err!.message + ". data: " + err!.data!.description);
        expectation.fulfill()
      });
      plugin.setUp(call!)
      wait(for: [expectation], timeout: 1);
    })();


    ({
      let expectation = XCTestExpectation(description: "[SET_UP] SUCCESS");
      let call = CAPPluginCall(callbackId: "test", options: [
        "key": "test_segment_key"
      ], success: { (result, call) in
        XCTAssertEqual(result!.data.count, 0);
        expectation.fulfill()
      }, error: { (err: CAPPluginCallError?) in
        XCTFail("🤦‍♂️ Error callback should not have been called")
        expectation.fulfill()
      });
      plugin.setUp(call!)
      wait(for: [expectation], timeout: 1);
    })();

    
    ({
      let expectation = XCTestExpectation(description: "[SET_UP] DUPE_CALL");
      let call = CAPPluginCall(callbackId: "test", options: [
        "key": "test_segment_key"
        ], success: { (result, call) in
          XCTFail("🤦‍♂️ Success callback should not have been called")
          expectation.fulfill()
      }, error: { (err: CAPPluginCallError?) in
        XCTAssertEqual(err!.message, "segment already set up");
        XCTAssertEqual(err!.data!["code"]! as? String, "[SET_UP] DUPE_CALL");
        expectation.fulfill()
      });
      plugin.setUp(call!)
      wait(for: [expectation], timeout: 1);
    })();
    
    // TODO: test location services and lifecycle

  }
  
  func testIdentify() {
    
    let plugin = SegmentPlugin();

    
    ({
      let expectation = XCTestExpectation(description: "[IDENTIFY] NOT_SET_UP");
      let call = CAPPluginCall(callbackId: "test", options: [:], success: { (result, call) in
        XCTFail("🤦‍♂️ Success callback should not have been called")
        expectation.fulfill()
      }, error: { (err: CAPPluginCallError?) in
        XCTAssertEqual(err!.message, "segment not set up");
        XCTAssertEqual(err!.data!["code"]! as? String, "[IDENTIFY] NOT_SET_UP");
        expectation.fulfill()
      });
      plugin.identify(call!)
      wait(for: [expectation], timeout: 1);
    })();

    
//    ({
//      let expectation = XCTestExpectation(description: "[IDENTIFY] NO_USER_ID");
//      let call = CAPPluginCall(callbackId: "test", options: [
//        "key": "test_segment_key"
//        ], success: { (result, call) in
//          XCTFail("🤦‍♂️ Success callback should not have been called")
//          expectation.fulfill()
//      }, error: { (err: CAPPluginCallError?) in
//        XCTAssertEqual(err!.message, "segment already set up");
//        XCTAssertEqual(err!.data!["code"]! as? String, "[SET_UP] DUPE_CALL");
//        expectation.fulfill()
//      });
//      plugin.setUp(call!)
//      wait(for: [expectation], timeout: 1);
//    })();
//
//
//    ({
//      let expectation = XCTestExpectation(description: "[IDENTIFY] SUCCESS");
//      let call = CAPPluginCall(callbackId: "test", options: [
//        "key": "test_segment_key"
//        ], success: { (result, call) in
//          XCTFail("🤦‍♂️ Success callback should not have been called")
//          expectation.fulfill()
//      }, error: { (err: CAPPluginCallError?) in
//        XCTAssertEqual(err!.message, "segment already set up");
//        XCTAssertEqual(err!.data!["code"]! as? String, "[SET_UP] DUPE_CALL");
//        expectation.fulfill()
//      });
//      plugin.setUp(call!)
//      wait(for: [expectation], timeout: 1);
//    })();

  }
  
}
