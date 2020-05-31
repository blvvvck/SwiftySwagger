import Foundation

protocol BaseEndPointType: EndPointType {}

extension BaseEndPointType {
	var baseURL: URL {
        return URL(string: "/api/v3")!
    }
}