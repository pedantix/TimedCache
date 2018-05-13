import Foundation

public protocol TimedCache {
    mutating func set(_ object: Any, for key: AnyHashable, expiring in: TimeInterval)
    mutating func set(_ object: Any, for key: AnyHashable)
    func get(key: AnyHashable) -> Any?
    subscript(key: AnyHashable) -> Any? { get set }
}
