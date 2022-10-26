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
     
        container.loadPersistentStores(completionHandler: { (_, error) in
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
    func getPropertieWithTitle(title: String, completion: ([Article]) -> Void) {
        let request: NSFetchRequest<Article> = Article.fetchRequest()
       
        request.predicate = NSPredicate(format: "title == %@", title )
        do {
            let properties = try CoreDataStack.sharedInstance.viewContext.fetch(request)
            try CoreDataStack.sharedInstance.viewContext.save()
            completion(properties)
        } catch {
            completion([])
        }
    }
    func delete (articleToDelete: NSManagedObject) {
        let _: NSFetchRequest<Article> = Article.fetchRequest()
        do {
            CoreDataStack.sharedInstance.viewContext.delete(articleToDelete)
            try CoreDataStack.sharedInstance.viewContext.save()
        } catch {
        }
    }
}
