//
//  QuizzView.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/11/10.
//

import SwiftUI

struct QuizzView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ViewModel
    
    
//    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.24, green: 0.39, blue: 0.51), location: 0.3),
                .init(color: Color(red: 0.13, green: 0.18, blue: 0.21), location: 0.3)
            ], center: .top, startRadius: 150, endRadius: 800)
                .ignoresSafeArea()
            
            // MARK: - Header Question
            VStack(spacing: 50) {
                Text("Question n° \(viewModel.currentQuestion + 1) sur \(viewModel.wrappedQuestionAmount)")
                    .font(.largeTitle)
                    .padding()
                    .background(.brown)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .offset(y: -30)
 
                // MARK: - Citation and answers

                VStack {
                    Section {
//                        Spacer()
                        if let citationRepresentable = viewModel.citations[viewModel.currentQuestion] {
                            Text(citationRepresentable.citation)
                                .padding()
                                .font(.headline)
                                .foregroundColor(.white)
                                .background(.black)
                                .cornerRadius(20)
                           
                        } else { Text("Error with the citation ") }
                    } header: {
                        Text("Citation")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .padding()
                    
                    Section {
                        Text("Quel est l'auteur de cette citation ?")
                            .font(.headline)
                            .foregroundColor(.white)
                        ForEach(0 ..< 3) { number in
                            
                            Button(action: {
                                viewModel.checkResponseUser(number: number)
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
                        .padding(.vertical, 4)
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                // MARK: - Last buttons

                VStack {
                    HStack {
                        Button {
                            viewModel.showingAlert = true
                        } label: {
                            Label("Stop", systemImage: "stop.circle.fill")
                        }
                        .buttonStyle(.bordered)
                        .tint(.white)
                        .alert("Attention", isPresented: $viewModel.showingAlert) {
                            Button("Oui c'est bon", role: .destructive, action: quitAndSaveTheGame)
                            Button("Je continue", role: .cancel) { }
                        } message: {
                            Text("Tu veux t'arrêter là ?")
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
                        .alert("Bien joué", isPresented: $viewModel.isQuizzFinished) {
                            Button("OK", role: .cancel, action: quitAndSaveTheGame)
                        } message: {
                            Text("Bravo tu as terminer et obtenu un score de \(viewModel.score) points")
                        }
                    }
                }
            }
            .padding(.horizontal, 10)
            .navigationBarBackButtonHidden(true)
            
            // MARK: - Navigation bar

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
            QuizzView(viewModel: QuizzView.ViewModel(citations: Citation.dumbCitation, citation: Citation.dumbCitation.first!, questionAmount: "5", challengeMode: true, characters: [["Arthur", "Jean", "Paul"], ["Jean", "Arthur", "Paul"]]))
//                .preferredColorScheme(.dark)
        }
    }
}
