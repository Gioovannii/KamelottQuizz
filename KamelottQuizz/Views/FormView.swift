//
//  FormView.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/11/11.
//

import SwiftUI

struct FormView: View {
    @StateObject private var viewModel = ViewModel()
    let layout = [ GridItem(.adaptive(minimum: 50, maximum: 100))]

    var images = ["1-beer", "2-cannon", "3-lute", "4-plastron", "1-beer", "2-cannon", "3-lute", "4-plastron"]
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Combien de questions ?"), footer: Text("Le mode challenge te permet d'acquerir de l'experience ainsi que des badges.")) {
                        Picker("Combien de questions", selection: $viewModel.questionSelection) {
                            ForEach(0 ..< viewModel.questions.count) {
                                Text("\(viewModel.questions[$0])")
                            }
                        }
                        .pickerStyle(.segmented)
                        .onChange(of: viewModel.questionSelection) { newValue in
                            if (newValue != 1) {
                                self.viewModel.showStartGame = true }
                        }
                        
                        Toggle("Le mode challenge ?", isOn: $viewModel.challengeMode.animation())
                    }
                    
                    Section {
                        NavigationLink("Commencer jeu") {
                            QuizzView(viewModel: QuizzView.ViewModel(citations: viewModel.citations, citation: (viewModel.citationRepresentable ?? Citation.dumbCitation.first)!, questionAmount: viewModel.questions[viewModel.questionSelection], challengeMode: viewModel.challengeMode, characters: viewModel.characters))
                        }
                        .foregroundColor(viewModel.showStartGame ? .accentColor : .gray)
                        .disabled(viewModel.showStartGame && viewModel.dataFetched ? false : true)
                
                        
                    } footer: {
                        Text("Veuillez patientez pendant le téléchargement des données.")
                    }
                    
                    
                    Section {
                        ScrollView {
                            LazyVGrid(columns: layout) {
                                ForEach(0..<images.count) { image in
                                    
                                    Image(images[image])
                                        .badgeImage(isUnlocked: true)
                                        
                                }
                            }
                        }
                        
                        
//                        HStack {
//                            Image("1-beer")
//                                .badgeImage(isUnlocked: true)
//
//                            Image("2-cannon")
//                                .badgeImage(isUnlocked: false)
//
//                            Image("3-lute")
//                                .badgeImage(isUnlocked: true)
//
//                            Image("4-plastron")
//                                .badgeImage(isUnlocked: true)
//                        }
                    } header: {
                        Text("Badges")
                    }
                }
            }
            .navigationTitle("Kaamelott")
        }
        .task {
            await viewModel.loadData()
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
            .preferredColorScheme(.dark)
    }
}
