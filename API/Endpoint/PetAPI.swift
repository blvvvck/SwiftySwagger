enum PetAPI {
  case addPet(pet: Pet)
  case updatePet(pet: Pet)
  case findPetsByStatus(status: String)
  case getPetById(petId: Int)
  case updatePetWithForm(name: String, status: String, petId: Int)
  case findPetsByTags(tags: [String])
  case uploadFile(additionalMetadata: String, petId: Int)
}

extension PetAPI: BaseEndPointType {
    // MARK: - Instance Properties

    var path: String {
        switch self {
        case .addPet:
          return "/pet"
        case .updatePet:
          return "/pet"
        case .findPetsByStatus:
          return "/pet/findByStatus"
        case let .getPetById(petId):
          return "/pet/\(petId)"
        case let .updatePetWithForm(name, status, petId):
          return "/pet/\(petId)"
        case .findPetsByTags:
          return "/pet/findByTags"
        case let .uploadFile(additionalMetadata, petId):
          return "/pet/\(petId)/uploadImage"
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
   		case .addPet:
   			return .post
   		case .updatePet:
   			return .put
   		case .findPetsByStatus:
   			return .get
   		case .getPetById:
   			return .get
   		case .updatePetWithForm:
   			return .post
   		case .findPetsByTags:
   			return .get
   		case .uploadFile:
   			return .post
        }
    }

    var task: HTTPTask {
        switch self {
          case let .addPet(pet):
            return .requestParameters(bodyParameters: pet, bodyEncoding: .jsonEncoding, urlParameters: nil)
            case let .updatePet(pet):
              return .requestParameters(bodyParameters: pet, bodyEncoding: .jsonEncoding, urlParameters: nil)
          case let .findPetsByStatus(status):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["status": status])
          case .getPetById:
            return .request
          case let .updatePetWithForm(name, status, petId):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["name": name, "status": status])
          case let .findPetsByTags(tags):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["tags": tags])
          case let .uploadFile(additionalMetadata, petId):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["additionalMetadata": additionalMetadata])
        }
    }

    var headers: HTTPHeaders? {
        return nil
    }
}