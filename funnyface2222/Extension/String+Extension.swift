

import UIKit
extension String {
    
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    func escape() -> String {
        let allowedCharacters = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return allowedCharacters
    }
    
    public func toInt() -> Int {
        guard let num = NumberFormatter().number(from: self) else { return 0 }
        return num.intValue
    }
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self,
                              options: Data.Base64DecodingOptions(rawValue: 0)) else { return nil }
        return String(data: data as Data, encoding: String.Encoding.utf8)
    }
    
    func toBase64() -> String? {
        guard let data = self.data(using: String.Encoding.utf8) else { return nil }
        return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
    }
    // MARK: - Validation
    var containsEmoji: Bool { contains { $0.isEmoji } }
    

    var isUserName: Bool {
        if isEmpty { return false }
        let usernameRegex = "^(?=.*[A-Za-z])(?=.*\\d).{8,}$"
        let usernameTest = NSPredicate(format: "SELF MATCHES %@", usernameRegex)
        return usernameTest.evaluate(with: self)
    }
    var isValidEmail: Bool {
        if isEmpty { return false }
        let emailRegex = "(?:[a-zA-Z0-9!#$%\\&‘*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
        "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
        "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
        "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
        "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
        "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
        "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let pred = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return pred.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        // Password must contain at least 6 characters and not contain emoji characters
        if self.count < 6 || self.containsEmoji {
            return false
        }
        return true
    }
}

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func heightOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.height
    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    
    func UTCToLocal(incomingFormat: String, outGoingFormat: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = incomingFormat
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            
            let dt = dateFormatter.date(from: self)
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = outGoingFormat
            
            return dateFormatter.string(from: dt ?? Date())
        }
    
    func getFormattedDate(strDate: String , currentFomat: String, expectedFromat: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = currentFomat

        let date : Date = dateFormatterGet.date(from: strDate) ?? Date()

        dateFormatterGet.dateFormat = expectedFromat
        return dateFormatterGet.string(from: date)
    }
}

extension Character {
    // A simple emoji is one scalar and presented to the user as an Emoji
    var isSimpleEmoji: Bool {
        guard let firstScalar = unicodeScalars.first else { return false }
        return firstScalar.properties.isEmoji && firstScalar.value > 0x238C
    }
    
    // Checks if the scalars will be merged into an emoji
    var isCombinedIntoEmoji: Bool { unicodeScalars.count > 1 && unicodeScalars.first?.properties.isEmoji ?? false }
    
    var isEmoji: Bool { isSimpleEmoji || isCombinedIntoEmoji }
}
