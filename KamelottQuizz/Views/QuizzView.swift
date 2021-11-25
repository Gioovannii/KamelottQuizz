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
    let game = Game()
    
    @State var citationRepresentable: Citation?
    @State private var currentQuestion = 1
    @State private var correctResponse = ""
    @State private var score = 0
    
    @State private var showingAlert = false
    
    var body: some View {
            VStack {
                Text("Score \(score)")
                
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
                
                Spacer()
                
                Section {
                    Text("Qui a dit cette citation")
                        .font(.headline)
                    ForEach(0 ..< 3) { number in
                        Button(action:  {
                            // do something when tapped
                           
                            
                        })  {
                            Text("\(game.characters[number]) ")}
                    }
                }
                .padding()
                
                Spacer()
                
                HStack {
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
                        loadData()
                    }
                    .disabled(questionAmount == String(currentQuestion) ? true : false)
                }
                .padding(30)
            }
            .onAppear(perform: loadData)
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

struct QuizzView_Previews: PreviewProvider {
    static var previews: some View {
        QuizzView(questionAmount: "10", challengeMode: true)
    }
}
