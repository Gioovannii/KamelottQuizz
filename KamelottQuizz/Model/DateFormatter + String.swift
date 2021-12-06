//
//  DatesManager.swift
//  KamelottQuizz
//
//  Created by Maxime on 04/12/2021.
//

import Foundation
 
extension String {
    func dateTodayString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy - HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "fr")
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        
        let dateFormated = dateFormatter.string(from: Date())
        return dateFormated
    }
}
