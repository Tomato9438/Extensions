//
//  NSColor+Extensions.swift
//  NSColorExtensionTest
//
//  Created by Kimberly on 2017/07/01.
//  Copyright © 2017 Kimberly. All rights reserved.
//

import Foundation
import Cocoa

extension NSColor {
    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(
            format: "%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
    
    convenience init?(hexString: String) {
        let r, g, b: CGFloat
        let start = hexString.index(hexString.startIndex, offsetBy: 1)
        let hexColor = (hexString.hasPrefix("#")) ? String(hexString[start...]) + "00" : hexString + "00"
        if hexColor.count == 8 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                self.init(red: r, green: g, blue: b, alpha: 1.0)
            }
            else {
                return nil
            }
        } else {
            return nil
        }
        // REF: httpS://www.hackingwithswift.com/example-code/uicolor/how-to-convert-a-hex-color-to-a-uicolor
    }
    
    func colorToComponents() -> [String] {
        let red = self.redComponent * 255.0
        let green = self.greenComponent * 255.0
        let blue = self.blueComponent * 255.0
        return [String(Int(red)), String(Int(green)), String(Int(blue))]
    }
}

// using hexString //
/*
let gold = NSColor(hexString: "#ffe700ff")
self.view.wantsLayer = true
self.view.layer?.backgroundColor = gold?.cgColor

let cyanColor = NSColor.cyan
let hex = cyanColor.toHexString
print(hex)
*/

// using colorToComponents //
/*
if let color = String.hexToColor(hexString: htmlField.stringValue) {
    htmlField.textColor = NSColor.black
    colorWell.color = color
    let rgbArray = color.colorToComponents()
    redField.stringValue = rgbArray[0]
    greenField.stringValue = rgbArray[1]
    blueField.stringValue = rgbArray[2]
}
*/

