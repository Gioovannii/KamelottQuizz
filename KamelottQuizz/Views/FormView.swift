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
    @State private var showingAlert = false
    
    var challengeDesctiption: String {
        challengeMode ? "Je choisis le mode challenge" : "Trop difficile pour moi le mode chalenge"
    }
    
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
                        
                        Toggle(isOn: $challengeMode.animation()) {
                            Text("Le mode challenge ?")
                        }
                        
                        
                    }
                                        
                    Section {
                        Button("Start Game") {
                            self.showingAlert.toggle()
                        }
                    }
                }
            }
            .navigationTitle("Kaamelott")
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Informations"), message: Text("Tu as choisis \(questions[questionSelection]) les questions \n \(challengeDesctiption)"), dismissButton: .cancel(Text("OK")))
            }
        }
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
