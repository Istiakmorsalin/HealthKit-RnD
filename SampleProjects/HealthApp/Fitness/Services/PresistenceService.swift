
import Foundation
import CoreData

class PersistanceService: Persistable {
    
    private init() {
    
    }
    
    static let shared = PersistanceService()
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Fitness")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
//    lazy var workoutContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "Workout")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        return container
//    }()
    
    var context: NSManagedObjectContext { return container.viewContext }
    
    func save() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
//    func saveWorkout() {
//        let context = workoutContainer.viewContext
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//
//                let nserror = error as NSError
//                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
//            }
//        }
//    }

    
}
