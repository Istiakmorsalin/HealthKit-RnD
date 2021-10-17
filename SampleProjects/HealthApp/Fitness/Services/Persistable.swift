import Foundation
import CoreData

protocol Persistable {
    
    var context: NSManagedObjectContext { get }
    var container: NSPersistentContainer { get }
    
    func save()
    
}
