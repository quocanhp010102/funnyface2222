

import Foundation

enum Enviroment {
    case staging
    case production
}

extension Enviroment {
    
    var baseURL: String {
        switch self {
        case .staging:
            return "https://databaseswap.mangasocial.online/"
        case .production:
            return "https://databaseswap.mangasocial.online/"
        }
    }
    
    var imgAPIURL: String {
        switch self {
        case .staging:
            return "https://api.imgbb.com/"
        case .production:
            return "https://api.imgbb.com/"
        }
    }
    
    var IPURL: String {
        switch self {
        case .staging:
            return "https://ipinfo.io/json"
        case .production:
            return "https://ipinfo.io/json"
        }
    }
}
