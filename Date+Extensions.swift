//
//  Date+Extensions.swift
//  Coupon Producer
//
//  Created by Kimberly on 2/4/18.
//  Copyright © 2018 Tom Bluewater. All rights reserved.
//

import Foundation

extension Date {
    /*
    func getLocalDate() -> Date? {
        let cal = Calendar.current
        let components = cal.dateComponents(in: NSTimeZone.local, from: self)
        if let offset = components.timeZone?.secondsFromGMT(for: self) {
            return Date().addingTimeInterval(Double(offset))
        }
        return nil
    }
    */
    
    func getLocalNow() -> Date? {
        // https://stackoverflow.com/questions/28404154/swift-get-local-date-and-time
        let timeZoneOffset = Double(TimeZone.current.secondsFromGMT(for: self))
        guard let localDate = Calendar.current.date(byAdding: .second, value: Int(timeZoneOffset), to: self) else {return Date()}
        return localDate
    }
    
    func getLocalDayofWeek() -> Int? {
        let cal = Calendar.current
        let components = cal.dateComponents(in: NSTimeZone.local, from: self)
        if let weekday = components.weekday {
            // https://developer.apple.com/documentation/foundation/nsdatecomponents/1410442-weekday
            // Sunday: 1, Monday: 2, Tuesday: 3, Wednesday: 4, Thursday: 5, Friday: 6, Saturday: 7 //
            return weekday
        }
        return nil
    }
    
    func getLocalYearNow() -> Int {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone.ReferenceType.local
        return cal.component(.year, from: self)
    }
    
    func getLocalMonthNow() -> Int {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone.ReferenceType.local
        return cal.component(.month, from: self)
    }
    
    func getLocalDayNow() -> Int {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone.ReferenceType.local
        return cal.component(.day, from: self)
    }
    
    func getLocalHourNow() -> Int {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone.ReferenceType.local
        return cal.component(.hour, from: self)
    }
    
    func getLocalMinuteNow() -> Int {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone.ReferenceType.local
        return cal.component(.minute, from: self)
    }
    
    func getLocalSecondNow() -> Int {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone.ReferenceType.local
        return cal.component(.second, from: self)
    }
    
    func getGMTYearNow() -> Int {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        return cal.component(.year, from: self)
    }
    
    func getGMTMonthNow() -> Int {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        return cal.component(.month, from: self)
    }
    
    func getGMTDayNow() -> Int {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        return cal.component(.day, from: self)
    }
    
    func getGMTHourNow() -> Int {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        return cal.component(.hour, from: self)
    }
    
    func getGMTMinuteNow() -> Int {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        return cal.component(.minute, from: self)
    }
    
    func getGMTSecondNow() -> Int {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        return cal.component(.second, from: self)
    }
    
    func getGMTYear(date: Date) -> Int {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        return cal.component(.year, from: date)
    }
    
    func getGMTMonth(date: Date) -> Int {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        return cal.component(.month, from: date)
    }
    
    func getGMTDay(date: Date) -> Int {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        return cal.component(.day, from: date)
    }
    
    func getGMTHour(date: Date) -> Int {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        return cal.component(.hour, from: date)
    }
    
    func getGMTMinute(date: Date) -> Int {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        return cal.component(.minute, from: date)
    }
    
    func getGMTSecond(date: Date) -> Int {
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = TimeZone(secondsFromGMT: 0)!
        return cal.component(.second, from: date)
    }
}

