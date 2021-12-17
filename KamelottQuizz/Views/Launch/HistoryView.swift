//
//  WelcomeView.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/9/2.
//

import SwiftUI

struct HistoryView: View {
    let coreDM : CoreDataManager
    
    @State private var gameSave = [GameSave]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(gameSave, id:\.self) { item in
                    HStack {
                        Text(item.date ?? "")
                        Spacer()
                        Text("Score : " + String(Int(item.score)))
                    }
                }
            }
            .listRowBackground(Color.white)
            .onAppear {
                gameSave = coreDM.getGameSave()
        }
            .navigationBarTitle("Historique")
        }
    }
    
    struct HistoryView_Previews: PreviewProvider {
        static var previews: some View {
            HistoryView(coreDM: CoreDataManager())
        }
    }
}
