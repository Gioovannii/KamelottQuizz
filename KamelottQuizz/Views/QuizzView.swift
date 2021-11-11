//
//  QuizzView.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/11/10.
//

import SwiftUI

struct QuizzView: View {
    @State var citationRepresentable: Citation?
    @State private var userTextField = ""
    
    
    var body: some View {
        NavigationView {
            VStack {
                
                Section(header: Text("Question")) {
                    
                }
                .padding()
                
                Section(header: Text("Citation")) {
                    if let citationRepresentable = citationRepresentable {
                        Text(citationRepresentable.citation)
                            .padding()
                    } else { Text("Error with the citation ") }
                    
                    TextField("Entrer le personnage", text: $userTextField, prompt: Text("Qui est le personnage ?"))
                        .padding()
                }
                .onAppear(perform: loadData)
                
            }
            .navigationTitle("Kaamelott")
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
}

struct QuizzView_Previews: PreviewProvider {
    static var previews: some View {
        QuizzView()
    }
}
