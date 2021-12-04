//
//  DatesManager.swift
//  KamelottQuizz
//
//  Created by Maxime on 04/12/2021.
//

import Foundation
 
class DatesManager {
    func dateTodayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "fr")
        dateFormatter.dateFormat = "dd MMM yyyy - HH:mm:ss"
        let dateFormated = dateFormatter.string(from: Date())
        return dateFormated
    }
}
