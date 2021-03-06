import Foundation

/// An object representing a Boolean schema type.
/// Get more info: https://swagger.io/specification/#schemaObject
public struct SwaggerBooleanSchema: Codable, Equatable {

    // MARK: - Nested Types

    private enum CodingKeys: String, CodingKey {

        // MARK: - Enumeration Cases

        case defaultValue = "default"
    }

    // MARK: - Type Properties

    internal static let typeCodingValue = "boolean"

    // MARK: - Instance Properties

    /// Default value.
    public var defaultValue: Bool?

    // MARK: - Initializers

    /// Creates a new instance with the provided values.
    public init(defaultValue: Bool? = nil) {
        self.defaultValue = defaultValue
    }
}
