enum UserAPI {
  case createUser(user: User)
  case loginUser(username: String, password: String)
  case createUsersWithListInput(users: [User])
  case logoutUser
  case getUserByName(username: String)
  case updateUser(user: User, username: String)
}

extension UserAPI: BaseEndPointType {
    // MARK: - Instance Properties

    var path: String {
        switch self {
        case .createUser:
          return "/user"
        case .loginUser:
          return "/user/login"
        case .createUsersWithListInput:
          return "/user/createWithList"
        case .logoutUser:
          return "/user/logout"
        case let .getUserByName(username):
          return "/user/\(username)"
        case let .updateUser(user, username):
          return "/user/\(username)"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
   		case .createUser:
   			return .post
   		case .loginUser:
   			return .get
   		case .createUsersWithListInput:
   			return .post
   		case .logoutUser:
   			return .get
   		case .getUserByName:
   			return .get
   		case .updateUser:
   			return .put
        }
    }

    var task: HTTPTask {
        switch self {
          case let .createUser(user):
            return .requestParameters(bodyParameters: user, bodyEncoding: .jsonEncoding, urlParameters: nil)
          case let .loginUser(username, password):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["username": username, "password": password])
          case let .createUsersWithListInput(users):
            return .requestParameters(bodyParameters: users, bodyEncoding: .jsonEncoding, urlParameters: nil)
          case .logoutUser:
            return .request
          case .getUserByName:
            return .request
            case let .updateUser(user, username):
              return .requestParameters(bodyParameters: user, bodyEncoding: .jsonEncoding, urlParameters: nil)
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }
}