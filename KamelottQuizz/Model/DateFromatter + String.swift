//
//  DateFromatter + String.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/12/3.
//

import Foundation

extension Date {
    func saveDate(inputDate: Date) -> String {
        
        let date = DateFormatter()
        
        date.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        date.locale = Locale(identifier: "fr_FR")
        date.dateStyle = .long
        date.timeStyle = .short
        let dateStr = date.string(from: inputDate)
        
        print(dateStr)
        return dateStr
    }
}
