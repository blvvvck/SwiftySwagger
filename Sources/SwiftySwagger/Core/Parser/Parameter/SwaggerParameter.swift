import Foundation

/// An object representing a parameter.
/// Get more info: https://swagger.io/specification/#parameterObject
public struct SwaggerParameter: Codable, Equatable {

    // MARK: - Nested Types

    private enum CodingKeys: String, CodingKey {

        // MARK: - Enumeration Cases

        case content
    }

    // MARK: - Instance Properties

    private var extensionsContainer: SwaggerExtensionsContainer

    // MARK: -

    /// Serialization type of the parameter.
    public var serialization: SwaggerParameterSerialization

    /// Metadata to describe the parameter.
    public var metadata: SwaggerParameterMetadata

    /// The extensions properties.
    /// Keys will be prefixed by "x-" when encoding.
    /// Values can be a primitive, an array or an object. Can have any valid JSON format value.
    public var extensions: [String: Any] {
        get { return extensionsContainer.content }
        set { extensionsContainer.content = newValue }
    }

    // MARK: - Initializers

    /// Creates a new instance with the provided values.
    public init(
        serialization: SwaggerParameterSerialization,
        metadata: SwaggerParameterMetadata,
        extensions: [String: Any] = [:]
    ) {
        self.extensionsContainer = SwaggerExtensionsContainer(content: extensions)

        self.serialization = serialization
        self.metadata = metadata
    }

    /// Creates a new instance by decoding from the given decoder.
    ///
    /// This initializer throws an error if reading from the decoder fails, or
    /// if the data read is corrupted or otherwise invalid.
    ///
    /// - Parameter decoder: The decoder to read data from.
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if container.contains(.content) {
            serialization = .content(try container.decode(forKey: .content))
        } else {
            serialization = .schema(try SwaggerParameterSchema(from: decoder))
        }

        metadata = try SwaggerParameterMetadata(from: decoder)
        extensionsContainer = try SwaggerExtensionsContainer(from: decoder)
    }

    // MARK: - Instance Methods

    /// Encodes this instance into the given encoder.
    ///
    /// This function throws an error if any values are invalid for the given encoder's format.
    ///
    /// - Parameter encoder: The encoder to write data to.
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        switch serialization {
        case let .content(content):
            try container.encode(content, forKey: .content)

        case let .schema(schema):
            try schema.encode(to: encoder)
        }

        try metadata.encode(to: encoder)
        try extensionsContainer.encode(to: encoder)
    }
}
