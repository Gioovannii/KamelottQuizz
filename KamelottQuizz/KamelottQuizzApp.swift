//
//  KamelottQuizzApp.swift
//  KamelottQuizz
//
//  Created by Giovanni Gaffé on 2021/9/2.
//

import SwiftUI

@main
struct KamelottQuizzApp: App {
    @Environment(\.scenePhase) var scenePhase
    let coreDataStack = CoreDataStack(modelName: "Model")

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, coreDataStack.persistentContainer.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            coreDataStack.saveContext()
        }
    }
}
