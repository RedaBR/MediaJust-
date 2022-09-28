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
   
    static let sharedInstance = CoreDataStack()
   
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "MediaJust")
     
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
   
    func getProperties(completion: ([Article]) -> Void) {
       
        let request: NSFetchRequest<Article> = Article.fetchRequest()
        do {
       
            let properties = try CoreDataStack.sharedInstance.viewContext.fetch(request)
        
            completion(properties)
        } catch {
            completion([])
        }
    }
    func getPropertieWithTitle(uri: String, completion: ([Article]) -> Void) {
        let request: NSFetchRequest<Article> = Article.fetchRequest()
       
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
