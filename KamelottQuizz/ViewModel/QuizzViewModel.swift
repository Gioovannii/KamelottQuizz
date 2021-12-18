//
//  QuizzViewModel.swift
//  KamelottQuizz
//
//  Created by Maxime on 24/11/2021.
//

import Foundation

extension QuizzView {
    @MainActor class ViewModel: ObservableObject {
        let coreDM = CoreDataManager()

        @Published var currentQuestion = 0
        @Published var score = 0
        @Published var isQuizzFinished = false
        @Published var updateUI = false

        var wrappedQuestionAmount: Int {
            Int(questionAmount) ?? 20
        }
        
        let citations: [Citation]
        let citation: Citation
        
        let questionAmount: String
        let challengeMode: Bool
        let characters: [[String]]
        
        
        init(citations: [Citation], citation: Citation,
             questionAmount: String, challengeMode: Bool, characters: [[String]]) {
            self.questionAmount = questionAmount
            self.challengeMode = challengeMode
            self.characters = characters
            self.citation = citation
            self.citations = citations
        }
        
        func nextQuestion() {
            if currentQuestion == wrappedQuestionAmount {
                self.updateUI = true
                self.isQuizzFinished = true
            } else {
                self.currentQuestion += 1

            }
            
        }
    }
}
