//
//  QuizzViewModel.swift
//  KamelottQuizz
//
//  Created by Maxime on 24/11/2021.
//

import Foundation

final class QuizzViewModel : ObservableObject {
    
    @Published var buttonName = "name"
    @Published var correctResponse = ""
    @Published var currentQuestion = 1
    @Published var score = 0
    @Published var showingAlert = false
    
    let citation: CitationRepresentable
    
    let questionAmount: String
    let challengeMode: Bool
    let characters: [String]

    
    init(citation: CitationRepresentable,
         questionAmount: String, challengeMode: Bool, characters: [String]) {
        self.questionAmount = questionAmount
        self.challengeMode = challengeMode
        self.characters = characters
        self.citation = citation
    }
}
