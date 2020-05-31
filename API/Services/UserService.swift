import Foundation

protocol UserServiceProtocol {
        func createUser(user: User, completion: @escaping (Swift.Result<User, Error>) -> Void)
        func loginUser(username: String, password: String, completion: @escaping (Swift.Result<String, Error>) -> Void)
        func createUsersWithListInput(users: [User], completion: @escaping (Swift.Result<User, Error>) -> Void)
        func logoutUser(completion: @escaping (Swift.Result<Void, Error>) -> Void)
        func getUserByName(username: String, completion: @escaping (Swift.Result<User, Error>) -> Void)
        func updateUser(user: User, username: String, completion: @escaping (Swift.Result<Void, Error>) -> Void)
}

struct UserService: UserServiceProtocol  {
    let router = Router<UserAPI>()

    func createUser(user: User, completion: @escaping (Swift.Result<User, Error>) -> Void) {
        router.request(.createUser(user: user)) { data, response, error in
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
                        let apiResponse = try JSONDecoder().decode(User.self, from: responseData)
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
    func loginUser(username: String, password: String, completion: @escaping (Swift.Result<String, Error>) -> Void) {
        router.request(.loginUser(username: username, password: password)) { data, response, error in
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
                        let apiResponse = try JSONDecoder().decode(String.self, from: responseData)
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
    func createUsersWithListInput(users: [User], completion: @escaping (Swift.Result<User, Error>) -> Void) {
        router.request(.createUsersWithListInput(users: users)) { data, response, error in
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
                        let apiResponse = try JSONDecoder().decode(User.self, from: responseData)
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

    func logoutUser(completion: @escaping (Swift.Result<Void, Error>) -> Void) {
        router.request(.logoutUser) { data, response, error in
            if error != nil {
                completion(.failure(error!))
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                        completion(.success(()))
                case let .failure(networkFailureError):
                    completion(.failure(NSError(domain: "", code: -3, userInfo: [NSLocalizedDescriptionKey : networkFailureError])))
                }
            }

        }
    }

    func getUserByName(username: String, completion: @escaping (Swift.Result<User, Error>) -> Void) {
        router.request(.getUserByName(username: username)) { data, response, error in
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
                        let apiResponse = try JSONDecoder().decode(User.self, from: responseData)
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
    func updateUser(user: User, username: String, completion: @escaping (Swift.Result<Void, Error>) -> Void) {
        router.request(.updateUser(user: user, username: username)) { data, response, error in
            if error != nil {
                completion(.failure(error!))
            }

            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                        completion(.success(()))
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