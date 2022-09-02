//
//  CalendarHelper.swift
//  viewFactory
//
//  Created by Pericles Narbal Da Costa De Oliveira (ACT CONSULTORIA EM TECNOLOGIA LTDA – DITEC – CE) on 23/08/22.
//

import Foundation

struct CalendarHelper {
    
    static let calendar = Calendar.current
    
    static func monthString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        dateFormatter.locale = Locale(identifier: "pt_BR")
        let month = dateFormatter.string(from: date)
        let formatedMonth = month.prefix(1).uppercased() + month.dropFirst()
        return formatedMonth
    }
    
    static func monthString(month: Int) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        guard let date = dateFormatter.date(from: "\(month)") else { return "" }
        dateFormatter.dateFormat = "LLLL"
        dateFormatter.locale = Locale(identifier: "pt_BR")
        let month = dateFormatter.string(from: date)
        let formatedMonth = month.prefix(1).uppercased() + month.dropFirst()
        return formatedMonth
    }
    
    static func month(date: Date) -> Int
    {
        let components = calendar.dateComponents([.month], from: date)
        guard let month = components.month else { return -1 }
        return month
    }
    
    static func yearString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    static func year(date: Date) -> Int
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        guard let year = Int(dateFormatter.string(from: date)) else { return -1 }
        return year
    }
    
    static func daysInMonth(date: Date) -> Int
    {
        guard let range = calendar.range(of: .day, in: .month, for: date) else { return -1 }
        return range.count
    }
    
    static func dayOfMonth(date: Date) -> Int
    {
        let components = calendar.dateComponents([.day], from: date)
        guard let day = components.day else { return -1 }
        return day
    }
    
    static func weekDay(date: Date) -> Int
    {
        let components = calendar.dateComponents([.weekday], from: date)
        guard let weekday = components.weekday else { return -1 }
        return weekday - 1
    }
    
    static func isPastDate(date: Date, granularity: Calendar.Component = .day) -> Bool {
        let order = Calendar.current.compare(Date(), to: date, toGranularity: granularity)
        return order == .orderedDescending
    }
    
    static func getDateBy(day: Int, month: Int, year: Int) -> Date? {
        let contextDateString = String(format: "%02d/%02d/%d", day, month, year)
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: contextDateString)
    }
    
    static func dateToString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
}
