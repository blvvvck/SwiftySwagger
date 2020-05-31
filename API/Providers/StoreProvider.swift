import Moya

enum StoreAPI {
  case getInventory
  case getOrderById(orderId: Int)
  case placeOrder(order: Order)
}

extension StoreAPI: BaseTargetType {
    // MARK: - Instance Properties

    var path: String {
        switch self {
        case .getInventory:
          return "/store/inventory"
        case let .getOrderById(orderId):
          return "/store/order/\(orderId)"
        case .placeOrder:
          return "/store/order"
        }
    }

    var method: Moya.Method {
        switch self {
   		case .getInventory:
   			return .get
   		case .getOrderById:
   			return .get
   		case .placeOrder:
   			return .post
        }
    }

    var task: Task {
        switch self {
          case .getInventory:
            return .requestPlain
          case .getOrderById:
            return .requestPlain
          case let .placeOrder(order):
            return .requestJSONEncodable(order)
        }
    }

    var sampleData: Data {
        return Data()
    }

    var headers: [String: String]? {
        return nil
    }
}