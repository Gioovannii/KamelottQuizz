//
//  FormViewModel.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/11/26.
//

import Foundation

extension FormView {
    @MainActor final class ViewModel: ObservableObject {
        @Published var citationRepresentable: Citation?
        @Published var characters = [[String]]()
        
        @Published var questions = ["5", "10", "15", "toutes"]
        
        @Published var questionSelection = 1
        @Published var challengeMode = false
        @Published var showStartGame = false
        @Published var dataFetched = false
        
        @Published var citations = [Citation]()
        
        private var urls = [URL]()
        private let game = Game()
        
        /// Load data form differents urls
        func loadData() async {
            
            urls = [URL]()
            characters = [[String]]()
            citations = [Citation]()
            urls = getURL()

            for url in urls {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                        Task { @MainActor in

                            citationRepresentable = Citation(citation: decodedResponse.citation.citation, infos: decodedResponse.citation.infos)
                            citations.append(citationRepresentable!)
                            
                            setupCharactersArray(decodedResponse: decodedResponse)
                            if citations.count == 20 { dataFetched = true }
                        }
                    }
                } catch {
                    print("Fetched failed: \(error.localizedDescription)")
                }
            }
        }
        
        private func setupCharactersArray(decodedResponse: Response) {
            var charactersRandom = [String]()
            
            guard let pickRandom1 = game.characters.randomElement() else { return }
            guard let pickRandom2 = game.characters.randomElement() else { return }

            charactersRandom.append(decodedResponse.citation.infos.personnage)

            if !charactersRandom.contains(pickRandom1) {
                charactersRandom.append(pickRandom1)
            } else {
                let pickAnotherElement = game.characters.randomElement()
                charactersRandom.append(pickAnotherElement!)
            }
            if !charactersRandom.contains(pickRandom2) {
                charactersRandom.append(pickRandom2)
            } else {
                let pickAnotherElement = game.characters.randomElement()
                charactersRandom.append(pickAnotherElement!)
            }
            
            charactersRandom.shuffle()

            self.characters.append(charactersRandom)
        }
        
        private func getURL() -> [URL] {
            var urls = [URL]()
            
            guard let url = URL(string: "https://kaamelott.chaudie.re/api/random") else {
                print("Invalid url")
                return [URL(string: "https://www.apple.com")!]
            }
            
            for _ in 0..<21 {
                urls.append(url)
            
            }
            return urls
        }
    }
}
