//
//  WelcomeView.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/9/2.
//

import SwiftUI

struct WelcomeView: View {
    let coreDM : CoreDataManager
    
    @State private var gameSave: [GameSave] = [GameSave]()
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(gameSave, id:\.self) { item in
                    HStack{
                        Text(item.date ?? "")
                        Text("Score : " + String(Int(item.score)))
                    }
                }
            }
            .onAppear{
                gameSave = coreDM.getGameSave()
        }
            .navigationBarTitle("Historique")
        }
    }
    
    struct WelcomeView_Previews: PreviewProvider {
        static var previews: some View {
            WelcomeView(coreDM: CoreDataManager())
        }
    }
}
