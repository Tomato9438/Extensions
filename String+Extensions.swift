//
//  String+Extensions.swift
//  ExtensionsTest
//
//  Created by Tom Bluewater on 12/8/16.
//  Copyright © 2016 Tom Bluewater. All rights reserved.
//

import Foundation

extension String {
    var data: Data { return Data(utf8) }
    var base64Encoded: Data { return data.base64EncodedData() }
    var base64Decoded: Data? { return Data(base64Encoded: self) }
    
    func isInt() -> Bool {
        if let _ = Int(self) {
            return true
        }
        else {
            return false
        }
    }
    
    func isPositiveInt() -> Bool {
        if let num = Int(self) {
            if num > 0 {
                return true
            } else {
                return false
            }
        }
        else {
            return false
        }
    }
    
    func isFloat() -> Bool {
        if let _ = Float(self) {
            return true
        }
        else {
            return false
        }
    }
    
    func isDouble() -> Bool {
        if let _ = Double(self) {
            return true
        }
        else {
            return false
        }
    }
    
    func isMacVersion() -> Bool {
        if let ver = Float(self) {
            if ver >= 10.7 {
                return true
            }
            else {
                return false
            }
        }
        else {
            return false
        }
    }
    
    func hasLineBreak() -> Bool {
        let strArray = self.components(separatedBy: CharacterSet.newlines)
        return (strArray.count <= 1) ? false : true
    }
    
    func getLeft(length: Int) -> String? {
        if length < 0 {
            return nil
        }
        else {
            if length <= self.count {
                let start = self.startIndex
                let end = self.index(self.endIndex, offsetBy: length - self.count) // going backwards from the end
                let substring = self[start..<end]
                return String(substring)
            } else {
                return nil
            }
        }
    }
    
    func getRight(length: Int) -> String? {
        if length < 0 {
            return nil
        }
        else {
            if length <= self.count {
                let start = self.index(self.startIndex, offsetBy: self.count - length)
                let end = self.endIndex
                let substring = self[start..<end]
                return String(substring)
            } else {
                return nil
            }
        }
    }
    
    func replaceAll(find: String, replace: String) -> String? {
        if self == "" {
            return nil
        } else {
            let str = self.replacingOccurrences(of: find, with: replace)
            return str
        }
    }
    
    func replaceAllWithArray(findArray: [String], str: String) -> String? {
        if findArray.count == 0 { return nil }
        else {
            var newStr = self
            for i in 0..<findArray.count {
                let search = findArray[i]
                newStr = newStr.replacingOccurrences(of: search, with: str)
            }
            return newStr
        }
    }
    
    func positionAt(position: Int) -> String? {
        // pisition of the first character is 0
        if position < 0 {
            return nil
        }
        else if position > self.count {
            return nil
        }
        else {
            if position <= self.count {
                let start = self.index(self.startIndex, offsetBy: position)
                let end = self.index(self.startIndex, offsetBy: position + 1)
                let subString = self[start..<end]
                return String(subString)
            } else {
                return nil
            }
        }
        /*
         let text = "0123456789"
         if let sub = text.positionAt(position: 5) {
         print(sub) // 5
         }
         */
    }
    
    func stringToCGFloat() -> CGFloat {
        let f = Float(self)!
        return CGFloat(f)
    }
    
    func getOccurrences(find: String) -> Int {
        let occurrenceArray = self.components(separatedBy: find)
        return (occurrenceArray.count - 1)
    }
    
    func getFirstElement(separator: String) -> String? {
        if separator == "" {
            return nil
        }
        else {
            if self.count > 0 {
                let array = self.components(separatedBy: separator)
                if let first = array.first {
                    return first
                } else {
                    return nil
                }
            } else {
                return nil
            }
        }
    }
    
    func getLastElement(separator: String) -> String? {
        if separator == "" {
            return nil
        }
        else {
            if self.count > 0 {
                let array = self.components(separatedBy: separator)
                if let last = array.last {
                    return last
                } else {
                    return nil
                }
            } else {
                return nil
            }
        }
    }
    
	func characterPositions(of string: String) -> [Int] {
		/* an array of Int is the positions of character occurrencies */
		return indices.reduce([]) { $1.utf16Offset(in: self) > ($0.last ?? -1) && self[$1...].hasPrefix(string) ? $0 + [$1.utf16Offset(in: self)] : $0 }
	}
	
    func isAlphabetLettersNumbersOnly() -> Bool {
        let letters = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
        let allowedDharacterSet = NSCharacterSet.init(charactersIn: letters)
        let characterSet = CharacterSet(charactersIn: self)
        if allowedDharacterSet.isSuperset(of: characterSet) {
            return true
        } else {
            return false
        }
    }
    
    func isVariableAcceptable() -> Bool {
        let firstElement = self.prefix(1)
        if !String(firstElement).isNumbersOnly(allow: false) {
            if !self.contains(" ") {
                let letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz._"
                let allowedDharacterSet = NSCharacterSet.init(charactersIn: letters)
                let characterSet = CharacterSet(charactersIn: self)
                if allowedDharacterSet.isSuperset(of: characterSet) {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    func isNumbersOnly(allow: Bool) -> Bool {
        // allowing '-' //
        if allow {
            let letters = "0123456789-"
            let allowedDharacterSet = NSCharacterSet.init(charactersIn: letters)
            let characterSet = CharacterSet(charactersIn: self)
            if allowedDharacterSet.isSuperset(of: characterSet) {
                return true
            } else {
                return false
            }
        } else {
            let letters = "0123456789"
            let allowedDharacterSet = NSCharacterSet.init(charactersIn: letters)
            let characterSet = CharacterSet(charactersIn: self)
            if allowedDharacterSet.isSuperset(of: characterSet) {
                return true
            } else {
                return false
            }
        }
    }
    
    func isNumbersOnly2(allow: Bool) -> Bool {
        // allowing white space //
        if allow {
            let letters = "0123456789 "
            let allowedDharacterSet = NSCharacterSet.init(charactersIn: letters)
            let characterSet = CharacterSet(charactersIn: self)
            if allowedDharacterSet.isSuperset(of: characterSet) {
                return true
            } else {
                return false
            }
        } else {
            let letters = "0123456789"
            let allowedDharacterSet = NSCharacterSet.init(charactersIn: letters)
            let characterSet = CharacterSet(charactersIn: self)
            if allowedDharacterSet.isSuperset(of: characterSet) {
                return true
            } else {
                return false
            }
        }
    }
    
    func isNumbersOnly3(allow: Bool) -> Bool {
        // allowing '.' //
        if allow {
            let letters = "0123456789."
            let allowedDharacterSet = NSCharacterSet.init(charactersIn: letters)
            let characterSet = CharacterSet(charactersIn: self)
            if allowedDharacterSet.isSuperset(of: characterSet) {
                return true
            } else {
                return false
            }
        } else {
            let letters = "0123456789"
            let allowedDharacterSet = NSCharacterSet.init(charactersIn: letters)
            let characterSet = CharacterSet(charactersIn: self)
            if allowedDharacterSet.isSuperset(of: characterSet) {
                return true
            } else {
                return false
            }
        }
    }
    
    func isASCIIOnly() -> Bool {
        let letters = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz !\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"
        let allowedDharacterSet = NSCharacterSet.init(charactersIn: letters)
        let characterSet = CharacterSet(charactersIn: self)
        if allowedDharacterSet.isSuperset(of: characterSet) {
            return true
        } else {
            return false
        }
    }
}

// Base64 //

/* converting a string into a Data object, which is then converted into a string of base64-encoded data object */
/*
if let id = transaction.transactionIdentifier {
    let iapFile = filePath1(name: "Receipt")
    let userName = NSUserName()
    let secs = Timedate.totalSeconds()
    let combinedStr = userName + "," + id + "," + String(secs)
    let utf8Data = combinedStr.data // Data
    let base64EncodedString = utf8Data.base64EncodedString()
    let base64EncodedData = NSKeyedArchiver.archivedData(withRootObject: "F48HQQ18348384823" + base64EncodedString)
    do {
        try base64EncodedData.write(to: URL(fileURLWithPath: iapFile), options: .atomicWrite)
    }
    catch {
    }
}
*/

/* converting a Data object into a string, which is base64-decoded and turned into the original string */
/*
if FileHandler.pathExists(path: iapFile) {
    if let data = NSKeyedUnarchiver.unarchiveObject(withFile: iapFile) {
        if let str = data as? String {
            if let base64EncodedString = str.replaceAll(find: "F48HQQ18348384823", replace: "") {
                if let decodedStr = base64EncodedString.base64Decoded?.string {
                    let commaComponents = decodedStr.components(separatedBy: ",")
                    let currentUser = NSUserName()
                    hasWindow = (commaComponents[0] == currentUser) ? true : false
                }
            }
        }
    }
}
*/

