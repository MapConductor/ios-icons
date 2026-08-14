import Foundation
import MapConductorCore

final class BitmapIconCache {
    static let shared = BitmapIconCache()

    private final class Entry: NSObject {
        let icon: BitmapIcon

        init(icon: BitmapIcon) {
            self.icon = icon
        }
    }

    private static let maxEntries = 512
    private static let maxCost = 32 * 1024 * 1024

    private let cache = NSCache<NSString, Entry>()
    private let lock = NSLock()

    private init() {
        cache.countLimit = Self.maxEntries
        cache.totalCostLimit = Self.maxCost
    }

    func value(forKey key: String, create: () -> BitmapIcon) -> BitmapIcon {
        lock.lock()
        defer { lock.unlock() }

        let cacheKey = key as NSString
        if let cached = cache.object(forKey: cacheKey) {
            return cached.icon
        }

        let icon = create()
        cache.setObject(Entry(icon: icon), forKey: cacheKey, cost: Self.cost(of: icon))
        return icon
    }

    private static func cost(of icon: BitmapIcon) -> Int {
        if let cgImage = icon.bitmap.cgImage {
            return cgImage.bytesPerRow * cgImage.height
        }

        let width = max(1, Int(ceil(icon.bitmap.size.width * icon.bitmap.scale)))
        let height = max(1, Int(ceil(icon.bitmap.size.height * icon.bitmap.scale)))
        return width * height * 4
    }
}
