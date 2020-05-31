import Foundation

protocol PetServiceProtocol {
        func addPet(pet: Pet, completion: @escaping (Swift.Result<Pet, Error>) -> Void)
        func updatePet(pet: Pet, completion: @escaping (Swift.Result<Pet, Error>) -> Void)
        func findPetsByStatus(status: String, completion: @escaping (Swift.Result<[Pet], Error>) -> Void)
        func getPetById(petId: Int, completion: @escaping (Swift.Result<Pet, Error>) -> Void)
        func updatePetWithForm(name: String, status: String, petId: Int, completion: @escaping (Swift.Result<Void, Error>) -> Void)
        func findPetsByTags(tags: [String], completion: @escaping (Swift.Result<[Pet], Error>) -> Void)
        func uploadFile(additionalMetadata: String, petId: Int, completion: @escaping (Swift.Result<ApiResponse, Error>) -> Void)
}

struct PetService: PetServiceProtocol  {
    let router = Router<PetAPI>()

    func addPet(pet: Pet, completion: @escaping (Swift.Result<Pet, Error>) -> Void) {
        router.request(.addPet(pet: pet)) { data, response, error in
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
                        let apiResponse = try JSONDecoder().decode(Pet.self, from: responseData)
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
    func updatePet(pet: Pet, completion: @escaping (Swift.Result<Pet, Error>) -> Void) {
        router.request(.updatePet(pet: pet)) { data, response, error in
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
                        let apiResponse = try JSONDecoder().decode(Pet.self, from: responseData)
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
    func findPetsByStatus(status: String, completion: @escaping (Swift.Result<[Pet], Error>) -> Void) {
        router.request(.findPetsByStatus(status: status)) { data, response, error in
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
                        let apiResponse = try JSONDecoder().decode([Pet].self, from: responseData)
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
    func getPetById(petId: Int, completion: @escaping (Swift.Result<Pet, Error>) -> Void) {
        router.request(.getPetById(petId: petId)) { data, response, error in
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
                        let apiResponse = try JSONDecoder().decode(Pet.self, from: responseData)
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
    func updatePetWithForm(name: String, status: String, petId: Int, completion: @escaping (Swift.Result<Void, Error>) -> Void) {
        router.request(.updatePetWithForm(name: name, status: status, petId: petId)) { data, response, error in
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
    func findPetsByTags(tags: [String], completion: @escaping (Swift.Result<[Pet], Error>) -> Void) {
        router.request(.findPetsByTags(tags: tags)) { data, response, error in
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
                        let apiResponse = try JSONDecoder().decode([Pet].self, from: responseData)
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
    func uploadFile(additionalMetadata: String, petId: Int, completion: @escaping (Swift.Result<ApiResponse, Error>) -> Void) {
        router.request(.uploadFile(additionalMetadata: additionalMetadata, petId: petId)) { data, response, error in
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
                        let apiResponse = try JSONDecoder().decode(ApiResponse.self, from: responseData)
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