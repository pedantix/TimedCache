import XCTest
@testable import TimedCache

final class DictionaryCacheTests: XCTestCase {
    let myTest = "MyTest"
    let myKey = "MyKey"

    func testGettingNotSetObject() {
        let dictCache = DictionaryCache()
        XCTAssertNil(dictCache[myKey])
        XCTAssertNil(dictCache.get(key: myKey))
    }

    func testSettingObjectNotExpired() {
        var dictCache = DictionaryCache()
        dictCache.set(myTest, for: myKey, expiring: 500)
        XCTAssertEqual(dictCache.get(key: myKey) as? String, myTest)
        XCTAssertEqual(dictCache[myKey] as? String, myTest)
    }

    func testSettingObjectExpired() {
        var dictCache = DictionaryCache()
        dictCache.set(myTest, for: myKey, expiring: -500)
        XCTAssertNil(dictCache[myKey])
        XCTAssertNil(dictCache.get(key: myKey))
    }

    func testBySettingWithoutExpiration() {
        var dictCache = DictionaryCache()
        dictCache.set(myTest, for: myKey)
        XCTAssertEqual(dictCache.get(key: myKey) as? String, myTest)
        XCTAssertEqual(dictCache[myKey] as? String, myTest)
    }

    func testBySettingWithoutExpirationWithSubscript() {
        var dictCache = DictionaryCache()
        dictCache[myKey] = myTest
        XCTAssertEqual(dictCache.get(key: myKey) as? String, myTest)
        XCTAssertEqual(dictCache[myKey] as? String, myTest)
    }

    func testRemove() {
        let myTest = "MyTest"
        let myKey = "MyKey"
        var dictCache = DictionaryCache()
        dictCache[myKey] = myTest
        XCTAssertEqual(dictCache.get(key: myKey) as? String, myTest)
        dictCache.remove(key: myKey)
        XCTAssertNil(dictCache[myKey])
    }

    func testDidReceiveMemoryWarning() {
        var dictCache = DictionaryCache()
        dictCache.set(myTest, for: myKey)
        XCTAssertEqual(dictCache.get(key: myKey) as? String, myTest)
        XCTAssertEqual(dictCache[myKey] as? String, myTest)

        dictCache.didReceiveMemoryWarning()
        XCTAssertEqual(dictCache.get(key: myKey) as? String, myTest)
        XCTAssertEqual(dictCache[myKey] as? String, myTest)


        dictCache.set(myTest, for: myKey, expiring: 500)
        XCTAssertEqual(dictCache.get(key: myKey) as? String, myTest)
        XCTAssertEqual(dictCache[myKey] as? String, myTest)

        dictCache.didReceiveMemoryWarning()
        XCTAssertEqual(dictCache.get(key: myKey) as? String, myTest)
        XCTAssertEqual(dictCache[myKey] as? String, myTest)
    }

    static var allTests = [
        ("testGettingNotSetObject", testGettingNotSetObject),
        ("testSettingObjectNotExpired", testSettingObjectNotExpired),
        ("testSettingObjectExpired", testSettingObjectExpired),
        ("testBySettingWithoutExpiration", testBySettingWithoutExpiration),
        ("testBySettingWithoutExpirationWithSubscript", testBySettingWithoutExpirationWithSubscript),
        ("testRemove", testRemove)
    ]
}
