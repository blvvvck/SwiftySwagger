

import Moya

/// Протокол MoyaProvider включающий в себя base url и authorization header
protocol BaseTargetType: TargetType {}

extension BaseTargetType {
    var baseURL: URL {
        return URL(string: "/api/v3")!
    }

    var validationType: ValidationType {
        return .successCodes
    }
}