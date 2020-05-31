import Foundation

	public struct JSONParameterEncoder: BodyEncoder {
		public func encode(urlRequest: inout URLRequest, with parameters: Encodable) throws {
			do {
				urlRequest.httpBody = parameters.toJSONData()
				if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
					urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
				}
			}catch {
				throw NetworkError.encodingFailed
			}
		}
	}

	extension Encodable {
		func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
	}

