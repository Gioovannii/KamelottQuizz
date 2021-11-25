//
//  QuizzViewModel.swift
//  KamelottQuizz
//
//  Created by Maxime on 24/11/2021.
//

import Foundation

final class QuizzViewModel : ObservableObject {
    
    @Published var citationRepresentable: Citation?
    @Published  var buttonName = "name"
    @Published  var correctResponse = ""
    @Published var personnages = [""]

    let questionAmount: String
    let challengeMode: Bool
    
    init(questionAmount: String, challengeMode: Bool) {
        self.questionAmount = questionAmount
        self.challengeMode = challengeMode
    }
    
    // load data from url
    func loadData() {
        guard let url = URL(string: "https://kaamelott.chaudie.re/api/random") else {
            print("Invalid url")
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        self.citationRepresentable = decodedResponse.citation
                    }
                    return
                }
            }
            print("Fetched failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}
