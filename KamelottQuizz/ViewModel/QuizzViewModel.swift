//
//  QuizzViewModel.swift
//  KamelottQuizz
//
//  Created by Maxime on 24/11/2021.
//

import Foundation

final class QuizzViewModel : ObservableObject {
    @Published var currentQuestion = 1
    @Published var score = 0
    
    var wrappedQuestionAmount: Int {
        Int(questionAmount) ?? 20
    }
    
    let citations: [Citation]
    let citation: Citation
    
    let questionAmount: String
    let challengeMode: Bool
    let characters: [[String]]
    
    let coreDM = CoreDataManager()
    
    init(citations: [Citation], citation: Citation,
         questionAmount: String, challengeMode: Bool, characters: [[String]]) {
        self.questionAmount = questionAmount
        self.challengeMode = challengeMode
        self.characters = characters
        self.citation = citation
        self.citations = citations
    }
    
    func nextQuestion() {
        guard currentQuestion < wrappedQuestionAmount else { return }
        self.currentQuestion += 1
    }

}
