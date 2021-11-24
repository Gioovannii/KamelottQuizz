//
//  QuizzView.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/11/10.
//

import SwiftUI

struct QuizzView: View {
    
    @StateObject private var viewModel = QuizzViewModel()
    
   
    var body: some View {
        NavigationView {
            VStack {
                Text("Question no \(viewModel.questionAmount)")
                    .font(.largeTitle)
                    .padding()
                
                Section(header: Text("Citation")) {
                    if let citationRepresentable = viewModel.citationRepresentable {
                        Text(citationRepresentable.citation)
                            .padding()
                        Text(citationRepresentable.infos.personnage)
                    } else { Text("Error with the citation ") }
                }
                
                Section {
                    ForEach(1 ..< 4) { number in
                        Button(action:  {
                            // do something when tapped
                            
                        })  { Text("Réponse \(number)") }
                    }
                }
                .padding()
                
                HStack(alignment: .center) {
                    Button("Stop") {
                        // When pressed stop
                    }
                    
                    Spacer()
                    
                    Button("Prochaine question") {
                        //When pressed next question
                    }
                }
                .padding(30)
            }
            .navigationTitle("Kaamelott")
            .onAppear(perform: viewModel.loadData)
        }
    }
}

struct QuizzView_Previews: PreviewProvider {
    static var previews: some View {
        QuizzView()
    }
}
