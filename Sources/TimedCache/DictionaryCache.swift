import Foundation

internal struct DictionaryCacheContainer {
    var expiration: Date?
    var cached: Any
}

struct DictionaryCache: TimedCache {
    private let queue: DispatchQueue = DispatchQueue(label: "com.shauncodes.DictionaryCache")
    private var dictionary: [AnyHashable: DictionaryCacheContainer] = [:]

    mutating func set(_ object: Any, for key: AnyHashable, expiring timeFromNow: TimeInterval) {
        queue.sync {
            let expiration = Date().addingTimeInterval(timeFromNow)
            dictionary[key] = DictionaryCacheContainer(expiration: expiration,
                                                       cached: object)
        }
    }

    mutating func set(_ object: Any, for key: AnyHashable) {
        queue.sync {
            dictionary[key] = DictionaryCacheContainer(expiration: nil, cached: object)
        }
    }


    func get(key: AnyHashable) -> Any? {
        return queue.sync {
            guard let cacheContainer = dictionary[key] else { return nil }
            guard let expiration = cacheContainer.expiration else {
                return cacheContainer.cached
            }
            guard expiration.compare(Date()) != .orderedAscending else { return nil }
            return cacheContainer.cached
        }
    }

    subscript(key: AnyHashable) -> Any? {
        get {
            return self.get(key: key)
        }

        set(value) {
            guard let val = value else { return }
            self.set(val, for: key)
        }
    }
}
