//
//  NSDate+Extension.swift
//  New
//
//  Created by 风晓得8023 on 15/11/10.
//  Copyright © 2015年 Tuofeng. All rights reserved.
//

import Foundation


public enum TFDateCompare:NSInteger {
    
    case Smaller = -1
    case Equal = 0
    case Plurality
}
    
extension NSDate{
    
    var calendar:NSCalendar {
        get {
            let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
            calendar.firstWeekday = 2
            return calendar
        }
    }
    
    var year:Int {
        get {
            return setComponents(.Year).year
        }
    }
    
    var month:Int {
        get {
            return setComponents(.Month).month
        }
    }
    
    var  day:Int {
        get {
            return setComponents(.Day).day
        }
    }
    
    var week:Int {
        get {
            return setComponents(.Weekday).weekday
        }
    }
    
    func countOfDaysInMonth() ->Int {
        return self.calendar.rangeOfUnit(NSCalendarUnit.Day, inUnit: NSCalendarUnit.Month, forDate: self).length
    }
    
    func countOfWeeksInMonth() ->Int {
        return self.calendar.rangeOfUnit(NSCalendarUnit.Weekday, inUnit: NSCalendarUnit.Month, forDate: self).length
    }
    
    func firstWeekDayInMonth() ->Int {
        let compoments = self.setComponents([NSCalendarUnit.Year,NSCalendarUnit.Month,NSCalendarUnit.Day])
        compoments.day = 1
        let newDate = self.calendar.dateFromComponents(compoments)
        return self.calendar.ordinalityOfUnit(NSCalendarUnit.Weekday, inUnit: NSCalendarUnit.WeekOfMonth, forDate: newDate!)
    }
    
    func weekInMonth() ->Int {
        return self.setComponents(NSCalendarUnit.WeekOfMonth).weekOfMonth
    }
    
    func weekInYear() ->Int {
        return self.setComponents(NSCalendarUnit.WeekOfYear).weekOfYear
    }
    
    func offsetMonth(numMonths:Int) ->NSDate {
        let offsetCompontents = NSDateComponents()
        offsetCompontents.month = numMonths
        return self.calendar.dateByAddingComponents(offsetCompontents, toDate: self, options: [])!
    }
    
    func offsetDay(numDays:Int) ->NSDate {
        let offsetCompontents = NSDateComponents()
        offsetCompontents.day = numDays
        return self.calendar.dateByAddingComponents(offsetCompontents, toDate: self, options: [])!
    }
    
    func setComponents(unitFlags:NSCalendarUnit) ->NSDateComponents{
        return self.calendar.components(unitFlags, fromDate: self)
    }
    
    /**
     方法名为了避免重写系统方法加了个With
     */
    func isEqualToWithDate(date:NSDate) ->Bool {
        
        if self.year == date.year && self.month == date.month && self.day == date.day {
            return true
        }else {
            return false
        }
    }
    
    func compareWithDate(aDate:NSDate) ->NSInteger {
        
        let yearB = self.year
        let yearA = aDate.year
        if yearB > yearA {
            return TFDateCompare.Plurality.rawValue
        }
        else if yearB < yearA {
            return TFDateCompare.Smaller.rawValue
        }else {
            
            let bMonth = self.month
            let aMonth = aDate.month
            
            if bMonth > aMonth {
                return TFDateCompare.Plurality.rawValue
            }
            else if bMonth < aMonth {
                return TFDateCompare.Smaller.rawValue
            }else {
                
                let bDay = self.day
                let aDay = aDate.day
                
                if bDay > aDay {
                    return TFDateCompare.Plurality.rawValue
                }
                else if bDay < aDay {
                    return TFDateCompare.Smaller.rawValue
                }else {
                    return TFDateCompare.Equal.rawValue
                }
            }
        }
    }
    
    func firstDayOfMonth() ->NSDate {
        
        var firstDay:NSDate?
        self.calendar.rangeOfUnit(NSCalendarUnit.Month, startDate: &firstDay, interval: nil, forDate: self)
        return firstDay!
    }
    
    /**
     返回指定格式的当前时间
     */
    class func currentTime(format:String) -> String {
        
        let currentDate = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.stringFromDate(currentDate)
    }
    
    /**
     时间转换
     */
    class func specifiedFormat(date:NSDate) ->String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.stringFromDate(date)
    }
    
    /**
     判断是否是历史
     */
    class func isHistoryday(target: Double) -> Bool {
        
        let targetDate = NSDate(timeIntervalSince1970: target / 1000)
        let currentDate = NSDate()
        let result = currentDate.timeIntervalSinceDate(targetDate) + 8 * 3600
        if result >= 24 * 60 * 60 {
            return true // 历史
        }
        return false  //当前
    }
    
    /**
     将XXXX-XX-XX的日期格式转成date
     */
    class func convertStringToDate(str:String) ->NSDate {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        return dateFormatter.dateFromString(str)!
    }
    
    /**
     获得当前时间的下个月时间戳
     */
    class func nextMonthTimeStamp() ->NSTimeInterval {
        let components = NSDateComponents()
        components.year = 0
        components.month = 1
        components.day = 0
        let date = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!.dateByAddingComponents(components, toDate: NSDate(), options: NSCalendarOptions.WrapComponents)!
        
        return date.timeIntervalSince1970
    }
    
    /// 扩展属性 返回时间
    var dateDesctiption: String {
        
        let cal = NSCalendar.currentCalendar()
        
        if cal.isDateInToday(self) {
            let delta = Int(NSDate().timeIntervalSinceDate(self))
            if delta < 60 {
                return "刚刚"
            }
            if delta < 3600 {
                return "\(delta / 60) 分钟前"
            }
            return "\(delta / 3600) 小时前"
        }
        
        var fmtString = " HH:mm"
        if cal.isDateInYesterday(self) {
            fmtString = "昨天" + fmtString
        } else {
            
            fmtString = "MM-dd" + fmtString
            let coms = cal.components(NSCalendarUnit.Year, fromDate: self, toDate: NSDate(), options: NSCalendarOptions(rawValue: 0))
            
            if coms.year > 0 {
                fmtString = "yyyy-" + fmtString
            }
        }
        
        let df = NSDateFormatter()
        df.locale = NSLocale(localeIdentifier: "en")
        df.dateFormat = fmtString
        
        return df.stringFromDate(self)
    }
}

    