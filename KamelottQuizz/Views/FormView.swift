//
//  FormView.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/11/11.
//

import SwiftUI

struct FormView: View {
    @StateObject private var viewModel = FormViewModel()
    
    let questions = ["5", "10", "15", "toutes"]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Combien de questions ?"), footer: Text("Le mode challenge te permet d'acquerir de l'experience ainsi que des badges.")) {
                        Picker("Combien de questions", selection: $viewModel.questionSelection) {
                            ForEach(0 ..< questions.count) {
                                Text("\(self.questions[$0])")
                            }
                        }
                        .pickerStyle(.segmented)
                        .onChange(of: viewModel.questionSelection) { newValue in
                            if (newValue != 1) { self.viewModel.showStartGame = true }
                        }
                        
                        Toggle(isOn: $viewModel.challengeMode.animation()) {
                            Text("Le mode challenge ?")
                        }
                    }
                    
                    Section {
                        NavigationLink("Commencer jeu") {
                            QuizzView(viewModel: QuizzViewModel(citations: viewModel.citations, citation: self.viewModel.citationRepresentable ?? Citation.dumbCitation, questionAmount: self.questions[viewModel.questionSelection], challengeMode: self.viewModel.challengeMode, characters: self.viewModel.characters), coreDM: CoreDataManager(), datesDM: DatesManager())
                        }
                        .foregroundColor(viewModel.showStartGame ? .accentColor : .gray)
                        .disabled(viewModel.showStartGame && viewModel.dataFetched ? false : true)
                    }
                    
                    
                    Section(header: Text("Badges")) {
                        HStack {
                            Image("kaamelott")
                                .resizable()
                                .frame(width: 55, height: 55)
                                .opacity(0.5)
                                .padding(.horizontal, 5)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            
                            Image("kaamelott")
                                .resizable()
                                .frame(width: 55, height: 55)
                                .padding(.horizontal)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            
                            Image("kaamelott")
                                .resizable()
                                .frame(width: 55, height: 55)
                                .padding(.horizontal)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    }
                }
            }
            .navigationTitle("Kaamelott")
        }
        .onAppear(perform: viewModel.loadData)
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
