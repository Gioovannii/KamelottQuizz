//
//  QuizzViewModel.swift
//  KamelottQuizz
//
//  Created by Maxime on 24/11/2021.
//

import Foundation

final class QuizzViewModel : ObservableObject {
    
    @Published var citationRepresentable: Citation?
    @Published var buttonName = "name"
    @Published var correctResponse = ""
    @Published var characters = [String]()
    
    let questionAmount: String
    let challengeMode: Bool
    
    init(questionAmount: String, challengeMode: Bool) {
        self.questionAmount = questionAmount
        self.challengeMode = challengeMode
    }
}
