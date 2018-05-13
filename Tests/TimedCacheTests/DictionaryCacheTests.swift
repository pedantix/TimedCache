import XCTest
@testable import TimedCache

final class DictionaryCacheTests: XCTestCase {
    func testGettingNotSetObject() {
        let myKey = "MyKey"
        let dictCache = DictionaryCache()
        XCTAssertNil(dictCache[myKey])
        XCTAssertNil(dictCache.get(key: myKey))
    }

    func testSettingObjectNotExpired() {
        let myTest = "MyTest"
        let myKey = "MyKey"
        var dictCache = DictionaryCache()
        dictCache.set(myTest, for: myKey, expiring: 500)
        XCTAssertEqual(dictCache.get(key: myKey) as? String, myTest)
        XCTAssertEqual(dictCache[myKey] as? String, myTest)
    }

    func testSettingObjectExpired() {
        let myTest = "MyTest"
        let myKey = "MyKey"
        var dictCache = DictionaryCache()
        dictCache.set(myTest, for: myKey, expiring: -500)
        XCTAssertNil(dictCache[myKey])
        XCTAssertNil(dictCache.get(key: myKey))
    }

    func testBySettingWithoutExpiration() {
        let myTest = "MyTest"
        let myKey = "MyKey"
        var dictCache = DictionaryCache()
        dictCache.set(myTest, for: myKey)
        XCTAssertEqual(dictCache.get(key: myKey) as? String, myTest)
        XCTAssertEqual(dictCache[myKey] as? String, myTest)
    }

    func testBySettingWithoutExpirationWithSubscript() {
        let myTest = "MyTest"
        let myKey = "MyKey"
        var dictCache = DictionaryCache()
        dictCache[myKey] = myTest
        XCTAssertEqual(dictCache.get(key: myKey) as? String, myTest)
        XCTAssertEqual(dictCache[myKey] as? String, myTest)
    }

    static var allTests = [
        ("testGettingNotSetObject", testGettingNotSetObject),
        ("testSettingObjectNotExpired", testSettingObjectNotExpired),
        ("testSettingObjectExpired", testSettingObjectExpired),
        ("testBySettingWithoutExpiration", testBySettingWithoutExpiration),
        ("testBySettingWithoutExpirationWithSubscript", testBySettingWithoutExpirationWithSubscript)
    ]
}
