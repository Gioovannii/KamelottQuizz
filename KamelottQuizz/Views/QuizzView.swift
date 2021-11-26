//
//  QuizzView.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/11/10.
//

import SwiftUI

struct QuizzView: View {

    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: QuizzViewModel
    
    let game = Game()
    
    @State var citationRepresentable: Citation?
    @State var currentQuestion = 1
    @State var correctResponse = ""
    @State var score = 0
    @State var showingAlert = false

    
    var body: some View {
            VStack {
                Text("Score \(score)")
                
                Text("Question no \(currentQuestion) on \(viewModel.questionAmount)")
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
                            Text("\(number)")}
                        
                    }
                }
                .padding()
                
                Spacer()
                
                HStack {
                    Button {
                        // When pressed stop
                        showingAlert.toggle()
//                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Label("Stop", systemImage: "stop.circle.fill")
                    }
                    .alert(isPresented: $showingAlert, content: {
                        Alert(title: Text("Attention"), message: Text("Tu veux t'arrêter là"), primaryButton: .cancel(Text("OK")), secondaryButton: .destructive(Text("Oh no"), action: quitGame))
                    })
                    .buttonStyle(.bordered)
                    .tint(.red)
                    
                    Spacer()
                    
                    Button {
                        //When pressed next question
                        guard let questionAmount = Int(viewModel.questionAmount) else { return }
                        guard currentQuestion < questionAmount else { return }
                        self.currentQuestion += 1
                        
                    } label: {
                        Label("Prochaine question", systemImage: "playpause.fill")
                    }
                    .disabled(viewModel.questionAmount == String(currentQuestion) ? true : false)
                    .buttonStyle(.bordered)
                    .tint(.blue)
                }
                .padding()
            }
    }
    
    
    func quitGame() { self.presentationMode.wrappedValue.dismiss() }
    
}

struct QuizzView_Previews: PreviewProvider {
    static var previews: some View {
        QuizzView(viewModel: QuizzViewModel(questionAmount: "10", challengeMode: true))
            .previewDevice("iPhone 13 Pro Max")
    }
}
