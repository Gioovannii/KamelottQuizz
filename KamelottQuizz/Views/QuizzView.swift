//
//  QuizzView.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/11/10.
//

import SwiftUI

struct QuizzView: View {
    @State var citationRepresentable: Citation?
    
    var body: some View {
        VStack {
            if let citationRepresentable = citationRepresentable {
                Text("Random Citation : \(citationRepresentable.citation)")
                    .padding()
            } else {
                Text("Error with the citation ")
            }
        }
        .onAppear(perform: loadData)
    }
    
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
            print("Fetche failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
        
        
    }
}

struct QuizzView_Previews: PreviewProvider {
    static var previews: some View {
        QuizzView()
    }
}
