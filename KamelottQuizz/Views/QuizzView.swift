//
//  QuizzView.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/11/10.
//

import SwiftUI

struct QuizzView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: QuizzViewModel
    
    @State private var showingAlert = false
    @State private var isQuizzFinished = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.24, green: 0.39, blue: 0.51), location: 0.3),
                .init(color: Color(red: 0.13, green: 0.18, blue: 0.21), location: 0.3)
            ], center: .top, startRadius: 150, endRadius: 800)
                .ignoresSafeArea()
            
            // MARK: - Header
            VStack(spacing: 50) {
                Text("Question n° \(viewModel.currentQuestion) sur \(viewModel.wrappedQuestionAmount)")
                    .font(.largeTitle)
                    .padding()
                    .background(.brown)
                    .foregroundColor(.white)
                    .cornerRadius(20)
 
                VStack {
                    Spacer()
                    Section(header: Text("Citation").font(.title2).foregroundColor(.white)) {
                        Spacer()
                        if let citationRepresentable = viewModel.citations[viewModel.currentQuestion - 1] {
                            
                            Text(citationRepresentable.citation)
                                .padding()
                                .font(.headline)
                                .foregroundColor(.white)
                                .background(.black)
                                .cornerRadius(20)
                        } else { Text("Error with the citation ") }
                        Spacer()
                        Spacer()
                        Spacer()
                    }
                    
                    Section {
                        
                        Text("Quel est l'auteur de cette citation ?")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                        ForEach(0 ..< 3) { number in
                            Button(action: {
                                print("Current question \(viewModel.currentQuestion)")
                                print("Question amount: \(viewModel.questionAmount)")
                                print(viewModel.citations.count)
                                print(viewModel.characters.enumerated())
                                
                                viewModel.currentQuestion += 1
//                                if viewModel.characters[viewModel.currentQuestion][number] == viewModel.citations[viewModel.currentQuestion].infos.personnage {
//                                    self.viewModel.score += 1
//                                    if viewModel.currentQuestion == viewModel.wrappedQuestionAmount {
//                                        self.isQuizzFinished = true
//                                    }
//                                    if isQuizzFinished {
//
//                                    } else {
//                                    viewModel.nextQuestion()
//                                    }
//                                } else { viewModel.nextQuestion() }
////                                if self.viewModel.currentQuestion == viewModel.wrappedQuestionAmount {
////                                    print("Lst question ? ")
//////                                    self.isQuizzFinished = true
////                                }
                                
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
                        .padding()
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                VStack {
                    HStack {
                        Button {
                            showingAlert = true
                        } label: {
                            Label("Stop", systemImage: "stop.circle.fill")
                        }
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
                    }
                }
            }
            .padding()
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
        }
    }
    
    // MARK: - Save in core data

    func quitAndSaveTheGame() {
        dismiss()
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
