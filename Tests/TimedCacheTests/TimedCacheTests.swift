import XCTest
@testable import TimedCache

final class TimedCacheTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(TimedCache().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
