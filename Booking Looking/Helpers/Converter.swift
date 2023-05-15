//
//  Converter.swift
//  Booking Looking
//
//  Created by Данила Парамин on 03.05.2023.
//

import Foundation


func monthNameFromNumberRu(_ month: Int) -> String {
        let monthNames = [
            "Январь", "Февраль", "Март", "Апрель", "Май", "Июнь",
            "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"
        ]
        guard month >= 1 && month <= 12 else {
            return "Неверный месяц"
        }
        return monthNames[month - 1]
    }

func monthNameFromNumberEng(_ month: Int) -> String {
    let monthNames = [
        "January", "February", "March", "April", "May", "June",
        "July", "August", "September", "October", "November", "December"
    ]
    guard month >= 1 && month <= 12 else {
        return "Invalid month"
    }
    return monthNames[month - 1]
}

func convertDatesToDictionary(_ dates: [Date]) -> [String: Any] {
    guard let firstDate = dates.first else {
        return [:]
    }
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM"
    let monthName = dateFormatter.string(from: firstDate)
    
    let year = Calendar.current.component(.year, from: firstDate)
    
    let dateNumbers = dates.map { Calendar.current.component(.day, from: $0) }
    
    return [
        "month": monthName,
        "year": year,
        "date": dateNumbers
    ]
}

struct YearMonth: Hashable {
    let year: Int
    let month: Int
}

func groupDatesByMonthAndYear(_ dates: [Date]) -> [[String: Any]] {
    var dateGroups: [YearMonth: [Int]] = [:]
    let calendar = Calendar.current

    for date in dates {
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        if let year = components.year, let month = components.month, let day = components.day {
            let yearMonth = YearMonth(year: year, month: month)
            if dateGroups[yearMonth] == nil {
                dateGroups[yearMonth] = []
            }
            dateGroups[yearMonth]?.append(day)
        }
    }

    return dateGroups.map { (yearMonth, days) in
        let monthName = monthNameFromNumberEng(yearMonth.month)
        return ["month": monthName, "year": yearMonth.year, "date": days]
    }
}
