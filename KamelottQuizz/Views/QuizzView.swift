//
//  QuizzView.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/11/10.
//

import SwiftUI

struct QuizzView: View {
    @Environment(\.presentationMode) var presentationMode
    let questionAmount: String
    let challengeMode: Bool
    
    @State var citationRepresentable: Citation?
    @State private var currentQuestion = 1
    @State private var correctResponse = ""
    
    var body: some View {
            VStack {
                Text("Question no \(currentQuestion) on \(questionAmount)")
                    .font(.largeTitle)
                    .padding()
                
                Section(header: Text("Citation")) {
                    if let citationRepresentable = citationRepresentable {
                        Text(citationRepresentable.citation)
                            .padding()
                        Text(citationRepresentable.infos.personnage)
                    } else { Text("Error with the citation ") }
                }
                
                Section {
                    ForEach(0 ..< 3) { number in
                        Button(action:  {
                            // do something when tapped
                            
                        })  {
                            Text("Réponse \(Game().characters[number]) ")}
                    }
                }
                .padding()
                
                HStack(alignment: .center) {
                    Button("Stop") {
                        // When pressed stop
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                    Spacer()
                    
                    Button("Prochaine question") {
                        //When pressed next question
                        guard let questionAmount = Int(questionAmount) else { return }
                        guard currentQuestion < questionAmount else { return }
                        self.currentQuestion += 1
                    }
                }
                .padding(30)
            }
            .onAppear(perform: loadData)
        }
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

struct QuizzView_Previews: PreviewProvider {
    static var previews: some View {
        QuizzView()
    }
}
