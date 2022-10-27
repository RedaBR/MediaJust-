//
//  MockCoreData.swift
//  MediaJustTests
//
//  Created by Reda on 20/10/2022.
//

import Foundation
import CoreData
@testable import MediaJust
// MARK: - Gestions Test Core Data
class MockCoreData {
// MARK: - managedObjectContextLazy
    lazy var lazyManagedObjectContext: NSManagedObjectContext = {
// Access to PersistentStoreCoordinator
        let coordinator = self.persistentStoreCoordinator
        let context = NSManagedObjectContext()
        context.persistentStoreCoordinator = coordinator
        return context
    }()
// MARK: - Managed object model
    lazy var lazyManagedObjectModel: NSManagedObjectModel = {
// Merge object of main bundel
        let managedObjecModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])
        return managedObjecModel!
    }()
// MARK: - persistentStoreCoordinator
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
var coordinator: NSPersistentStoreCoordinator? =
    NSPersistentStoreCoordinator(managedObjectModel: lazyManagedObjectModel)
        // Save in memory
        do {
            try coordinator!.addPersistentStore(ofType: NSInMemoryStoreType,
            configurationName: nil, at: nil, options: nil)
        } catch {
            coordinator = nil
            print("Error")
        }
        return coordinator!
    }()
    // MARK: - Managed object context 
    var managedObjectContext: NSManagedObjectContext {
        return lazyManagedObjectContext
    }
}
