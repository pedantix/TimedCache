import Foundation

internal enum Node {
    case expiring(Date, Any)
    case nonExpiring(Any)

    var cached: Any {
        switch self {
        case let .expiring(_, data):
            return data
        case let .nonExpiring(data):
            return data
        }
    }

    var expired: Bool {
        guard case let .expiring(date, _) = self else  { return false }
        return date.compare(Date()) == .orderedAscending
    }
}

public struct DictionaryCache: TimedCache {
    private let queue: DispatchQueue = DispatchQueue(label: "com.shauncodes.DictionaryCache")
    private var dictionary: [AnyHashable: Node] = [:]

    public mutating func set(_ object: Any, for key: AnyHashable, expiring timeFromNow: TimeInterval) {
        queue.sync {
            let expiration = Date().addingTimeInterval(timeFromNow)
            dictionary[key] = Node.expiring(expiration, object)
        }
    }

    public mutating func set(_ object: Any, for key: AnyHashable) {
        queue.sync {
            dictionary[key] = .nonExpiring(object)
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
