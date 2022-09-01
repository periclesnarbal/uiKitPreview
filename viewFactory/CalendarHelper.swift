//
//  CalendarHelper.swift
//  viewFactory
//
//  Created by Pericles Narbal Da Costa De Oliveira (ACT CONSULTORIA EM TECNOLOGIA LTDA – DITEC – CE) on 23/08/22.
//

import Foundation

struct CalendarHelper {
    
    let calendar = Calendar.current
    
    func monthString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        dateFormatter.locale = Locale(identifier: "pt_BR")
        let month = dateFormatter.string(from: date)
        let formatedMonth = month.prefix(1).uppercased() + month.dropFirst()
        return formatedMonth
    }
    
    func monthString(month: Int) -> String
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
    
    func month(date: Date) -> Int
    {
        let components = calendar.dateComponents([.month], from: date)
        guard let month = components.month else { return -1 }
        return month
    }
    
    func yearString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }
    
    func year(date: Date) -> Int
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        guard let year = Int(dateFormatter.string(from: date)) else { return -1 }
        return year
    }
    
    func daysInMonth(date: Date) -> Int
    {
        guard let range = calendar.range(of: .day, in: .month, for: date) else { return -1 }
        return range.count
    }
    
    func dayOfMonth(date: Date) -> Int
    {
        let components = calendar.dateComponents([.day], from: date)
        guard let day = components.day else { return -1 }
        return day
    }
    
    func weekDay(date: Date) -> Int
    {
        let components = calendar.dateComponents([.weekday], from: date)
        guard let weekday = components.weekday else { return -1 }
        return weekday - 1
    }
    
    func isPastDate(date: Date, granularity: Calendar.Component = .day) -> Bool {
        let order = Calendar.current.compare(Date(), to: date, toGranularity: granularity)
        return order == .orderedDescending
    }
    
    func getDateBy(day: Int, month: Int, year: Int) -> Date? {
        let contextDateString = String(format: "%02d/%02d/%d", day, month, year)
        let dateFormatter  = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: contextDateString)
    }
    
    func dateToString(date: Date) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date)
    }
}
