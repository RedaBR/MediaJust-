//
//  CoreDataStack.swift
//  MediaJust
//
//  Created by Reda on 27/09/2022.
//

import Foundation
import CoreData

class CoreDataStack {
    private init() {}
    // MARK: - Persistent Container CoreData
    static let sharedInstance = CoreDataStack()
    // Access to the container to name the database
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MediaJust")
        // Access to PersistentStore
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    var viewContext: NSManagedObjectContext {
        return CoreDataStack.sharedInstance.persistentContainer.viewContext
    }
    // MARK: - CoreData requests
    func getProperties(completion: ([Article]) -> Void) {
        // request
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        do {
        // request execution
            let properties = try CoreDataStack.sharedInstance.viewContext.fetch(request)
        // get the result of request
            completion(properties)
        } catch {
            completion([])
        }
    }
    func getPropertieWithTitle(uri: String, completion: ([Article]) -> Void) {
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        // Precision of request
        request.predicate = NSPredicate(format: "uri == %@", uri )
        do {
            let properties = try CoreDataStack.sharedInstance.viewContext.fetch(request)
            try CoreDataStack.sharedInstance.viewContext.save()
            completion(properties)
        } catch {
            completion([])
        }
    }
    func delete (recipeToDelete: NSManagedObject) {
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        do {
            let properties = try CoreDataStack.sharedInstance.viewContext.delete(recipeToDelete)
            try CoreDataStack.sharedInstance.viewContext.save()
        } catch {
        }
    }
}
