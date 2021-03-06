import Foundation

extension KeyedDecodingContainerProtocol {

    // MARK: - Instance Methods

    internal func decode<T: Decodable>(_ type: T.Type = T.self, forKey key: Key) throws -> T {
        return try decode(type, forKey: key)
    }

    internal func decodeIfPresent<T: Decodable>(_ type: T.Type = T.self, forKey key: Self.Key) throws -> T? {
        return try decodeIfPresent(type, forKey: key)
    }
}
