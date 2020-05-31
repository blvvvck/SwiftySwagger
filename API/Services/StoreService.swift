import Foundation

protocol StoreServiceProtocol {
        func getOrderById(orderId: Int, completion: @escaping (Swift.Result<Order, Error>) -> Void)
        func placeOrder(order: Order, completion: @escaping (Swift.Result<Order, Error>) -> Void)
        func getInventory(completion: @escaping (Swift.Result<, Error>) -> Void)
}

struct StoreService: StoreServiceProtocol  {
    let router = Router<StoreAPI>()

    func getOrderById(orderId: Int, completion: @escaping (Swift.Result<Order, Error>) -> Void) {
        router.request(.getOrderById(orderId: orderId)) { data, response, error in
            if error != nil {
                completion(.failure(error!))
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: NetworkResponse.noData.rawValue])))
                        return
                    }

                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        let apiResponse = try JSONDecoder().decode(Order.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.unableToDecode.rawValue])))
                    }
                case let .failure(networkFailureError):
                    completion(.failure(NSError(domain: "", code: -3, userInfo: [NSLocalizedDescriptionKey : networkFailureError])))
                }
            }

        }
    }
    func placeOrder(order: Order, completion: @escaping (Swift.Result<Order, Error>) -> Void) {
        router.request(.placeOrder(order: order)) { data, response, error in
            if error != nil {
                completion(.failure(error!))
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: NetworkResponse.noData.rawValue])))
                        return
                    }

                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        let apiResponse = try JSONDecoder().decode(Order.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.unableToDecode.rawValue])))
                    }
                case let .failure(networkFailureError):
                    completion(.failure(NSError(domain: "", code: -3, userInfo: [NSLocalizedDescriptionKey : networkFailureError])))
                }
            }

        }
    }

    func getInventory(completion: @escaping (Swift.Result<, Error>) -> Void) {
        router.request(.getInventory) { data, response, error in
            if error != nil {
                completion(.failure(error!))
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: NetworkResponse.noData.rawValue])))
                        return
                    }

                    do {
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        let apiResponse = try JSONDecoder().decode(.self, from: responseData)
                        completion(.success(apiResponse))
                    } catch {
                        completion(.failure(NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey : NetworkResponse.unableToDecode.rawValue])))
                    }
                case let .failure(networkFailureError):
                    completion(.failure(NSError(domain: "", code: -3, userInfo: [NSLocalizedDescriptionKey : networkFailureError])))
                }
            }

        }
    }


    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
} 