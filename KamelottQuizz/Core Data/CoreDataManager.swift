import CoreData
class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    // MARK: - Initializer
    init() {
        persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data Store failed \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Manage Entity
    
    func saveTheGame(date:String,score:Int) {
        let gameSave = GameSave(context:persistentContainer.viewContext)
        gameSave.date = date
        gameSave.score = Double(score)
        save()
        print(gameSave.score)
    }
    
    // MARK: - Tools
    func save(){
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save movie \(error)")
        }
    }
}
