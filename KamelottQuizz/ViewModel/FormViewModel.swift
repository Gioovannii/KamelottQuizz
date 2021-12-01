//
//  FormViewModel.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/11/26.
//

import Foundation

final class FormViewModel: ObservableObject {


    @Published var citationRepresentable: Citation?
    @Published var characters = [[String]]()
    
    @Published var questionSelection = 1
    @Published var challengeMode = false
    @Published var showStartGame = false
    @Published var dataFetched = false
    
    
    @Published var citations = [Citation]()
    
    private var urls = [URL]()
    let game = Game()

    /// Load data from url
    func loadData() {
        self.urls = getURL()
        for url in urls {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                        DispatchQueue.main.async {
                            self.citationRepresentable = Citation(citation: decodedResponse.citation.citation, infos: decodedResponse.citation.infos)
                            self.citations.append(self.citationRepresentable!)
                            self.dataFetched = true
                            
                            guard let pickRandom1 = self.game.characters.randomElement() else { return }
                            guard let pickRandom2 = self.game.characters.randomElement() else { return }

                            var charactersRandom = [pickRandom1, pickRandom2, decodedResponse.citation.infos.personnage]
                            charactersRandom.shuffle()
                            
                            self.characters.append(charactersRandom)
                            print(self.characters)
                            print(self.citations)
                        }
                        return
                    }
                }
                print("Fetched failed: \(error?.localizedDescription ?? "Unknown error")")
            }.resume()
        }
    }
    
    
    func getURL() -> [URL] {
        var urls = [URL]()
        
        guard let url = URL(string: "https://kaamelott.chaudie.re/api/random") else {
            print("Invalid url")
            return [URL(string: "https://www.apple.com")!]
        }
        
        for _ in 0...20 {
            urls.append(url)
        }
        return urls
    }
}
