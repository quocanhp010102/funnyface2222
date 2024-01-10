

import Foundation

extension Optional {
    func asStringOrEmpty() -> String {
        switch self {
        case .some(let value):
            return String(describing: value)
        case _:
            return ""
        }
    }
    
    func asStringOrNilText() -> String {
        switch self {
        case .some(let value):
            return String(describing: value)
        case _:
            return "(nil)"
        }
    }
    
    func asIntOrEmpty() -> String {
        switch self {
        case .some(let value):
            return String(describing: value)
        case _:
            return "0"
        }
    }
}
