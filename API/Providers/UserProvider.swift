import Moya

enum UserAPI {
  case loginUser(username: String, password: String)
  case logoutUser
  case getUserByName(username: String)
  case updateUser(user: User, username: String)
  case createUsersWithListInput(users: [User])
  case createUser(user: User)
}

extension UserAPI: BaseTargetType {
    // MARK: - Instance Properties

    var path: String {
        switch self {
        case .loginUser:
          return "/user/login"
        case .logoutUser:
          return "/user/logout"
        case let .getUserByName(username):
          return "/user/\(username)"
        case let .updateUser(user, username):
          return "/user/\(username)"
        case .createUsersWithListInput:
          return "/user/createWithList"
        case .createUser:
          return "/user"
        }
    }

    var method: Moya.Method {
        switch self {
   		case .loginUser:
   			return .get
   		case .logoutUser:
   			return .get
   		case .getUserByName:
   			return .get
   		case .updateUser:
   			return .put
   		case .createUsersWithListInput:
   			return .post
   		case .createUser:
   			return .post
        }
    }

    var task: Task {
        switch self {
          case let .loginUser(username, password):
            return .requestParameters(parameters: ["username": username, "password": password], encoding: JSONEncoding.default)
          case .logoutUser:
            return .requestPlain
          case .getUserByName:
            return .requestPlain
          case let .createUsersWithListInput(users):
            return .requestJSONEncodable(users)
          case let .createUser(user):
            return .requestJSONEncodable(user)
        }
    }

    var sampleData: Data {
        return Data()
    }

    var headers: [String: String]? {
        return nil
    }
}