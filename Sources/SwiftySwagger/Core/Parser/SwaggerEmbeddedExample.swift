import Foundation

/// An object representing an embedded example.
/// Get more info: https://swagger.io/specification/#exampleObject
public struct SwaggerEmbeddedExample: Codable {

    // MARK: - Instance Properties

    /// A free-form value of the example.
    /// To represent an example that cannot be naturally represented in JSON or YAML,
    /// a string value can be used to contain the example with escaping where necessary.
    public var value: Any

    // MARK: - Initializers

    /// Creates a new instance with the provided value.
    public init(_ value: Any) {
        self.value = value
    }

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()

        value = try container.decode(AnyCodable.self).value
    }

    // MARK: - Instance Methods

    /// Encodes this instance into the given encoder.
    ///
    /// This function throws an error if any values are invalid for the given encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()

        try container.encode(AnyCodable(value))
    }
}

// MARK: - Equatable

extension SwaggerEmbeddedExample: Equatable {

    // MARK: - Type Methods

    /// Returns a Boolean value indicating whether two instances are equal.
    public static func == (lhs: SwaggerEmbeddedExample, rhs: SwaggerEmbeddedExample) -> Bool {
        return AnyCodable(lhs.value) == AnyCodable(rhs.value)
    }
}
