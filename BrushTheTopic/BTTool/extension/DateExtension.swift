//
//  DateExtension.swift
//  AssetsTransfer
//
//  Created by 石山岭 on 2020/4/13.
//  Copyright © 2020 云象. All rights reserved.
//

import Foundation
import CommonCrypto
extension Date {
    
    /// String -> Date
    ///
    /// - Parameters:
    ///   - dateStr: date string
    ///   - formatter: date formatter
    /// - Returns: Date
    static func date(_ dateStr: String, formatter: String = "yyyy-MM-dd HH:mm:ss") -> Date? {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = formatter
        
        dateFormatter.locale = Locale.current
        
        return dateFormatter.date(from: dateStr)
    }
    /// 获取时间对应的时间戳
    func getTimeStamp() -> String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
    ///把date转成字符串
    func dateToString(_ format:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter:DateFormatter = DateFormatter()
        formatter.dateFormat = format
        return  formatter.string(from: self)
    }
    ///获取date对应的这个月的总天数
    func totalDaysInMonth() -> Int {
        return NSCalendar.current.range(of: .day, in: .month, for: self)?.count ?? 0
    }
    
    static func currentCalendar() -> Calendar {
        var sharedCalendar = Calendar(identifier: .gregorian)
        
        sharedCalendar.locale = Locale.current
        
        return sharedCalendar
    }
    
    
    
    
    /// Example: 2000/1/2 03:04:05 return 2000
    var year: Int {
        get {
            return Date.currentCalendar().component(.year, from: self)
        }
    }
    
    /// Example: 2000/1/2 03:04:05 return 1
    var month: Int {
        get {
            return Date.currentCalendar().component(.month, from: self)
        }
    }
    
    /// Example: 2000/1/2 03:04:05 return 2
    var day: Int {
        get {
            return Date.currentCalendar().component(.day, from: self)
        }
    }
    
    /// Example: 2000/1/2 03:04:05 return 3
    var hour: Int {
        get {
            return Date.currentCalendar().component(.hour, from: self)
        }
    }
    
    /// Example: 2000/1/2 03:04:05 return 4
    var minute: Int {
        get {
            return Date.currentCalendar().component(.minute, from: self)
        }
    }
    
    /// Example: 2000/1/2 03:04:05 return 5
    var second: Int {
        get {
            return Date.currentCalendar().component(.second, from: self)
        }
    }
    
}
extension Date {
    
    /// the same year
    ///
    /// - Parameter date: contrast time
    /// - Returns: true: equal; false: not equal
    func haveSameYear(_ date: Date) -> Bool {
        return self.year == date.year
    }
    
    func haveSameYearAndMonth(_ date: Date) -> Bool {
        return self.haveSameYear(date) && self.month == date.month
    }
    
    func haveSameYearMonthAndDay(_ date: Date) -> Bool {
        let components1 = Date.currentCalendar().dateComponents([.year, .month, .day], from: self)
        let components2 = Date.currentCalendar().dateComponents([.year, .month, .day], from: date)
        return components1 == components2
    }
    
    func haveSameYearMonthDayAndHour(_ date: Date) -> Bool {
        let components1 = Date.currentCalendar().dateComponents([.year, .month, .day, .hour], from: self)
        let components2 = Date.currentCalendar().dateComponents([.year, .month, .day, .hour], from: date)
        return components1 == components2
    }
    
    func haveSameYearMonthDayHourAndMinute(_ date: Date) -> Bool {
        let components1 = Date.currentCalendar().dateComponents([.year, .month, .day, .hour, .minute], from: self)
        let components2 = Date.currentCalendar().dateComponents([.year, .month, .day, .hour, .minute], from: date)
        return components1 == components2
    }
    
    func haveSameYearMonthDayHourMinuteAndSecond(_ date: Date) -> Bool {
        let components1 = Date.currentCalendar().dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        let components2 = Date.currentCalendar().dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        return components1 == components2
    }
}

extension Date {
    
    /// the number of days in the month
    ///
    /// - Returns: number of day
    func numberOfDaysInMonth() -> Int {
        if let range = Date.currentCalendar().range(of: .day, in: .month, for: self) {
            return range.count
        }
        
        return 0
    }
}

