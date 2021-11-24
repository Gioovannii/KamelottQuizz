//
//  QuizzViewModel.swift
//  KamelottQuizz
//
//  Created by Maxime on 24/11/2021.
//

import Foundation

final class QuizzViewModel : ObservableObject {
    
    @Published var citationRepresentable: Citation?
    @Published var questionAmount = 1
    @Published  var buttonName = "name"
    @Published  var correctResponse = ""
    @Published var personnages = [""]
    
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
    
    private func encode(baseUrl: URL, with parameters: [(String, Any)]?) -> URL {
        guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false), let parameters = parameters, !parameters.isEmpty else { return baseUrl }
        urlComponents.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let querryItem = URLQueryItem(name: key, value: "\(value)")
            urlComponents.queryItems?.append(querryItem)
        }
        guard let url = urlComponents.url else { return baseUrl }
        return url
    }
}
