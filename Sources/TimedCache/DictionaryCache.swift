import Foundation

internal struct DictionaryCacheContainer {
    var expiration: Date?
    var cached: Any

    var expired: Bool {
        return ((expiration?.compare(Date()) ?? .orderedSame) == .orderedAscending)
    }
}

public struct DictionaryCache: TimedCache {
    private let queue: DispatchQueue = DispatchQueue(label: "com.shauncodes.DictionaryCache")
    private var dictionary: [AnyHashable: DictionaryCacheContainer] = [:]

    public mutating func set(_ object: Any, for key: AnyHashable, expiring timeFromNow: TimeInterval) {
        queue.sync {
            let expiration = Date().addingTimeInterval(timeFromNow)
            dictionary[key] = DictionaryCacheContainer(expiration: expiration,
                                                       cached: object)
        }
    }

    public mutating func set(_ object: Any, for key: AnyHashable) {
        queue.sync {
            dictionary[key] = DictionaryCacheContainer(expiration: nil, cached: object)
        }
    }


    public func get(key: AnyHashable) -> Any? {
        return queue.sync {
            guard let cacheContainer = dictionary[key],
                !cacheContainer.expired else { return nil }
            return cacheContainer.cached
        }
    }

    public subscript(key: AnyHashable) -> Any? {
        get {
            return self.get(key: key)
        }

        set(value) {
            guard let val = value else { return }
            self.set(val, for: key)
        }
    }

    public mutating func remove(key: AnyHashable) {
        queue.sync {
            _ = dictionary.removeValue(forKey: key)
        }
    }

    public mutating func didReceiveMemoryWarning() {
        queue.sync {
            for (key,value) in dictionary {
                if value.expired {
                    dictionary.removeValue(forKey: key)
                }
            }
        }
    }
}
