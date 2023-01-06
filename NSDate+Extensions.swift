//
//  NSDate+Extensions.swift
//  3DTouch
//
//  Created by Tom Bluewater on 9/5/16.
//  Copyright © 2016 Tom Bluewater. All rights reserved.
//

import Foundation

extension NSDate {
    static func getYear(date: NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date as Date)
    }
    
    static func getMonth(date: NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: date as Date)
    }
    
    static func getDay(date: NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date as Date)
    }
    
    static func getHours(date: NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH"
        return dateFormatter.string(from: date as Date)
    }
    
    static func getHours2(date: NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh"
        return dateFormatter.string(from: date as Date)
    }
    
    static func getMinutes(date: NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "mm"
        return dateFormatter.string(from: date as Date)
    }
    
    static func getSeconds(date: NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ss"
        return dateFormatter.string(from: date as Date)
    }
    
    static func getMidday(date: NSDate) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a"
        return dateFormatter.string(from: date as Date)
    }
    
    static func getDiff(date: NSDate) -> String {
        // Difference from Greenich
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ZZZ"
        return dateFormatter.string(from: date as Date)
    }
    
    static func dayOfWeek(date: NSDate) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date as Date).capitalized
        // or capitalized(with: locale)
    }
    
    static func monthName(date: NSDate) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        return dateFormatter.string(from: date as Date).capitalized
        // or capitalized(with: locale)
    }
}

