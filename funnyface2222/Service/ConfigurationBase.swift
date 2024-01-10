

import Foundation
import Alamofire

enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}

enum Task {
    case requestPlain
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding = URLEncoding.default)
}

protocol Configuration {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: Task {get}
    var headers: [String: String]? { get }
    var data: Data? { get }
}

struct ServiceError: Error {
    let issueCode: IssueCode
    var message: String {
        return issueCode.message
    }
    static var urlError: ServiceError {
        return ServiceError(issueCode: IssueCode.CUSTOM_MES(message: "URL is wrong"))
    }
    static var notFoundData: ServiceError {
        return ServiceError(issueCode: IssueCode.CUSTOM_MES(message: "Not found Data"))
    }
    
    static var parseError: ServiceError {
        return ServiceError(issueCode: IssueCode.CUSTOM_MES(message: "Parse Model Error"))
    }
    
    static var jsonError: ServiceError {
        return ServiceError(issueCode: IssueCode.CUSTOM_MES(message: "Response is not JSON"))
    }
    
    static var somethinkWrong: ServiceError {
        return ServiceError(issueCode: IssueCode.CUSTOM_MES(message: "Something went wrong"))
    }
}

// MARK: - Issue
final class Issue: Codable {
    let statusCode: Int
    let statusTxt: String
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusTxt = "status_txt"
    }
}

enum IssueCode {
    case CUSTOM_MES(message: String)

    static func initValue(value: String) -> IssueCode {
        return .CUSTOM_MES(message: value)
    }
    
    var message: String {
        switch self {
        case .CUSTOM_MES(let message):
            return message
        }
    }
}

extension IssueCode {
    private static func issueCode(fromCode code: String) -> IssueCode {
        return initValue(value: code.uppercased())
    }
}
