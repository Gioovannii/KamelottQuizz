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

    var body: some View {
        VStack {
            Text("Question no \(viewModel.currentQuestion) on \(viewModel.questionAmount)")
                .font(.largeTitle)
                .padding()
            
            Section(header: Text("Citation")) {
                if let citationRepresentable = viewModel.citations[viewModel.currentQuestion - 1] {
                    
                    LinearGradient(gradient: Gradient(colors: [.red, .black, .orange]), startPoint: .leading, endPoint: .trailing)
                        .mask(Text(citationRepresentable.citation))
                        .padding(.horizontal)


                    Text("Reponse \(citationRepresentable.infos.personnage)")
                } else { Text("Error with the citation ") }
            }
            
            Section {
                Text("Qui a dit cette citation")
                    .font(.headline)
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        // do something when tapped
                        
                        if viewModel.characters[viewModel.currentQuestion - 1][number] ==  viewModel.citations[viewModel.citations[curre]]{
                        nextQuestion()
                        }
                    }) {
                        if viewModel.characters.count > 1 {
                            Text("\(viewModel.characters[viewModel.currentQuestion - 1][number])")
                        } else {
                            Text("Loading")
                        }
                    }
                }
            }
            .padding()
            
            Spacer()
            
            HStack {
                Button {
                    viewModel.showingAlert.toggle()
                } label: {
                    Label("Stop", systemImage: "stop.circle.fill")
                }
                .alert(isPresented: $viewModel.showingAlert) {
                    Alert(title: Text("Attention"), message: Text("Tu veux t'arrêter là"), primaryButton: .cancel(Text("Je continue.")), secondaryButton: .destructive(Text("Oui c'est bon."), action: quitGame))
                }
                .buttonStyle(.bordered)
                .tint(.red)
                
                Spacer()
                
                Button {
                    nextQuestion()
                    
                } label: {
                    Label("Prochaine question", systemImage: "playpause.fill")
                }
                .disabled(viewModel.questionAmount == String(viewModel.currentQuestion) ? true : false)
                .buttonStyle(.bordered)
                .tint(.blue)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Text("score \(viewModel.score)")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Text(self.viewModel.challengeMode ? "Mode challenge activé" : "Mode challenge desactivé")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
        }
    }
    
    func quitGame() { self.presentationMode.wrappedValue.dismiss() }
    
    func nextQuestion() {
        guard let questionAmount = Int(viewModel.questionAmount) else { return }
        guard viewModel.currentQuestion < questionAmount else { return }
        self.viewModel.currentQuestion += 1
    }
}

struct QuizzView_Previews: PreviewProvider {
    static var previews: some View {
        QuizzView(viewModel: QuizzViewModel(citations: [Citation.dumbCitation], citation: Citation.dumbCitation, questionAmount: "10", challengeMode: true, characters: [["Arthur", "Jean", "Paul"]]))
    }
}
