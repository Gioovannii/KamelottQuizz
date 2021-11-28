//
//  FormViewModel.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/11/26.
//

import Foundation

final class FormViewModel : ObservableObject {

    @Published var citationRepresentable: CitationRepresentable?
    @Published var characters = [String]()
    
    @Published var questionSelection = 1
    @Published var challengeMode = false
    @Published var showStartGame = false
    @Published var dataFetched = false
    
    let game = Game()

    /// Load data from url
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
                        
                        let randomsElement = self.game.pickRandomCharacters(answer: decodedResponse.citation.infos.personnage)
                        self.characters = randomsElement
                        print(self.characters)
                    }
                    return
                }
            }
            print("Fetched failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
    
    //    func loadData() {
    //        guard let url = URL(string: "https://kaamelott.chaudie.re/api/random") else {
    //            print("Invalid url")
    //            return
    //        }
    //
    //        let request = URLRequest(url: url)
    //        URLSession.shared.dataTask(with: request) { data, response, error in
    //            if let data = data {
    //                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
    //                    DispatchQueue.main.async {
    //                        self.citationRepresentable = decodedResponse.citation
    //                        self.game.randomCharacters = self.game.pickRandomCharacters(answer: decodedResponse.citation.infos.personnage)
    //                    }
    //                    return
    //                }
    //            }
    //            print("Fetched failed: \(error?.localizedDescription ?? "Unknown error")")
    //        }.resume()
    //    }
}
