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
    
    @State private var showingAlert = false
    @State private var isQuizzFinished = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.24, green: 0.39, blue: 0.51), location: 0.3),
                .init(color: Color(red: 0.80, green: 0.56, blue: 0.21), location: 0.3)
            ], center: .top, startRadius: 250, endRadius: 500)
                .ignoresSafeArea()
            VStack {
                Text("Question n° \(viewModel.currentQuestion) sur \(viewModel.wrappedQuestionAmount)")
                    .font(.largeTitle)
                    .padding()
                    .background(.brown)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                
                Section(header: Text("Citation").font(.title2)
                            .foregroundColor(.white))
                {
                    if let citationRepresentable = viewModel.citations[viewModel.currentQuestion - 1] {
                        Spacer()
                        Text(citationRepresentable.citation)
                            .padding()
                            .font(.headline)
                            .foregroundColor(.white)
                            .background(.black)
                            .cornerRadius(20)
                    } else { Text("Error with the citation ") }
                }
                
                Section {
                    Text("Quel est l'auteur de cette citation ?")
                        .font(.headline)
                        .foregroundColor(.white)
                    ForEach(0 ..< 3) { number in
                        Button(action: {
                            
                            if viewModel.characters[viewModel.currentQuestion][number] == viewModel.citations[viewModel.currentQuestion].infos.personnage {
                                self.viewModel.score += 1
                                
                                viewModel.nextQuestion()
                            } else { viewModel.nextQuestion() }
                            if self.viewModel.currentQuestion == viewModel.wrappedQuestionAmount {
                                self.isQuizzFinished = true
                            }
                            
                        }) {
                            if viewModel.characters.count > 1 {
                                Text("\(viewModel.characters[viewModel.currentQuestion][number])")
                            } else {
                                Text("Loading")
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(Color.brown)
                    }
                }
                .padding()
                
                Spacer()
                
                HStack {
                    Button {
                        showingAlert = true
                    } label: {
                        Label("Stop", systemImage: "stop.circle.fill")
                    }
                    .padding(.leading, 10)
                    .buttonStyle(.bordered)
                    .tint(.white)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Attention"), message: Text("Tu veux t'arrêter là"), primaryButton: .cancel(Text("Je continue.")), secondaryButton: .destructive(Text("Oui c'est bon."), action: quitAndSaveTheGame))
                    }
                    
                    Spacer()
                    
                    Button {
                        viewModel.nextQuestion()
                        
                    } label: {
                        Label("Prochaine question", systemImage: "playpause.fill")
                    }
                    .disabled(viewModel.wrappedQuestionAmount == viewModel.currentQuestion ? true : false)
                    .buttonStyle(.bordered)
                    .tint(.white)
                    .alert(isPresented: $isQuizzFinished) {
                        Alert(title: Text("Bravo, tu as terminé le quizz"), message: Text("Tu as obtenu un score de \(self.viewModel.score)"), dismissButton: .default(Text("Bien joué"), action: quitAndSaveTheGame))
                    }
                    .padding()
                }
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Text("score \(viewModel.score)")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Text(self.viewModel.challengeMode ? "Mode challenge activé" : "Mode challenge desactivé")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
            }
//            .background(Color("dark"))
        }
    }
    
    
    func quitAndSaveTheGame() {
        self.presentationMode.wrappedValue.dismiss()
        viewModel.coreDM.saveTheGame(date: String().dateTodayString() , score: viewModel.score)
    }
}

struct QuizzView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            QuizzView(viewModel: QuizzView.QuizzViewModel(citations: [Citation.dumbCitation], citation: Citation.dumbCitation, questionAmount: "10", challengeMode: true, characters: [["Arthur", "Jean", "Paul"], ["Jean", "Arthur", "Paul"]]))
        }
    }
}
