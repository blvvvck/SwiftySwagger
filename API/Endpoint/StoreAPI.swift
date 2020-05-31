enum StoreAPI {
  case getOrderById(orderId: Int)
  case placeOrder(order: Order)
  case getInventory
}

extension StoreAPI: BaseEndPointType {
    // MARK: - Instance Properties

    var path: String {
        switch self {
        case let .getOrderById(orderId):
          return "/store/order/\(orderId)"
        case .placeOrder:
          return "/store/order"
        case .getInventory:
          return "/store/inventory"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
   		case .getOrderById:
   			return .get
   		case .placeOrder:
   			return .post
   		case .getInventory:
   			return .get
        }
    }

    var task: HTTPTask {
        switch self {
          case .getOrderById:
            return .request
          case let .placeOrder(order):
            return .requestParameters(bodyParameters: order, bodyEncoding: .jsonEncoding, urlParameters: nil)
          case .getInventory:
            return .request
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }
}