//
//  DateUtils.swift
//  Cocktails
//
//  Created by Fabijan Mihanović on 31.05.2024..
//

import Foundation

class DateUtils {

    static func categorizeDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale.current

        guard let date = dateFormatter.date(from: dateString) else {
            return "Invalid date"
        }

        let currentDate = Date()
        let calendar = Calendar.current

        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: currentDate)?.start ?? currentDate
        let startOfMonth = calendar.dateInterval(of: .month, for: currentDate)?.start ?? currentDate
        let startOfYear = calendar.date(from: DateComponents(year: calendar.component(.year, from: currentDate), month: 1, day: 1)) ?? currentDate

        if calendar.isDateInToday(date) {
            return "date.utils.today".localize()
        } else if date >= startOfWeek {
            return "date.utils.thisWeek".localize()
        } else if date >= startOfMonth {
            return "date.utils.thisMonth".localize()
        } else if date >= startOfYear {
            return "date.utils.thisYear".localize()
        } else {
            let yearsDiff = calendar.dateComponents([.year], from: date, to: currentDate).year ?? 0
            return "\(yearsDiff) \("date.utils.yearsAgo".localize())"
        }
    }

}
