import XCTest

import TimedCacheTests

var tests = [XCTestCaseEntry]()
tests += TimedCacheTests.allTests()
XCTMain(tests)