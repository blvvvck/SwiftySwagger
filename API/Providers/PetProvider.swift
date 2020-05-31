import Moya

enum PetAPI {
  case addPet(pet: Pet)
  case updatePet(pet: Pet)
  case getPetById(petId: Int)
  case updatePetWithForm(petId: Int, name: String, status: String)
  case findPetsByTags(tags: [String])
  case findPetsByStatus(status: String)
  case uploadFile(petId: Int, additionalMetadata: String)
}

extension PetAPI: BaseTargetType {
    // MARK: - Instance Properties

    var path: String {
        switch self {
        case .addPet:
          return "/pet"
        case .updatePet:
          return "/pet"
        case let .getPetById(petId):
          return "/pet/\(petId)"
        case let .updatePetWithForm(petId, name, status):
          return "/pet/\(petId)"
        case .findPetsByTags:
          return "/pet/findByTags"
        case .findPetsByStatus:
          return "/pet/findByStatus"
        case let .uploadFile(petId, additionalMetadata):
          return "/pet/\(petId)/uploadImage"
        }
    }

    var method: Moya.Method {
        switch self {
   		case .addPet:
   			return .post
   		case .updatePet:
   			return .put
   		case .getPetById:
   			return .get
   		case .updatePetWithForm:
   			return .post
   		case .findPetsByTags:
   			return .get
   		case .findPetsByStatus:
   			return .get
   		case .uploadFile:
   			return .post
        }
    }

    var task: Task {
        switch self {
          case let .addPet(pet):
            return .requestJSONEncodable(pet)
          case .getPetById:
            return .requestPlain
          case let .findPetsByTags(tags):
            return .requestParameters(parameters: ["tags": tags], encoding: JSONEncoding.default)
          case let .findPetsByStatus(status):
            return .requestParameters(parameters: ["status": status], encoding: JSONEncoding.default)
        }
    }

    var sampleData: Data {
        return Data()
    }

    var headers: [String: String]? {
        return nil
    }
}