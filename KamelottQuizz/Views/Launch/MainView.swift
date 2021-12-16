//
//  MainView.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/11/30.
//
import UIKit
import SwiftUI

struct MainView: View {
//    init() {
//        UITableView.appearance().backgroundColor = UIColor(Color("dark"))
//    }
    
    var body: some View {
        
        TabView {
            HistoryView(coreDM: CoreDataManager())
                .tabItem {
                    Label("Accueil", systemImage: "house.fill")
                }
            
            FormView()
                .tabItem {
                    Label("Quizz", systemImage: "gamecontroller.fill")
                }
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
