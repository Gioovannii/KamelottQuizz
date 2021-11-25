//
//  FormView.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/11/11.
//

import SwiftUI

struct FormView: View {
    @State private var questionSelection = 1
    @State private var challengeMode = false

    @State private var showStartGame = false
    
    let questions = ["5", "10", "15", "toutes"]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Combien de questions ?"), footer: Text("Le mode challenge te permet d'acquerir de l'experience ainsi que des badges.")) {
                        Picker("Combien de questions", selection: $questionSelection) {
                            ForEach(0 ..< questions.count) {
                                Text("\(self.questions[$0])")
                            }
                            
                        }
                        .pickerStyle(.segmented)
                        .onChange(of: questionSelection) { newValue in
                            if (newValue != 1) { self.showStartGame = true }
                        }
                        
                        
                        Toggle(isOn: $challengeMode.animation()) {
                            Text("Le mode challenge ?")
                        }
                    }
                    
                    
                    Section {
                        NavigationLink("Commencer jeu") {
                            QuizzView(questionAmount: questions[questionSelection], challengeMode: challengeMode)
                        }
                        .opacity(showStartGame ? 1 : 0.3)
                        .foregroundColor(showStartGame ? .accentColor : .gray)
                    }
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
            .navigationTitle("Kaamelott")
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
