//
//  MockCoreData.swift
//  MediaJustTests
//
//  Created by Reda on 20/10/2022.
//

import Foundation
import CoreData
@testable import MediaJust

class MockCoreData {
    
    lazy var lazyManagedObjectContext : NSManagedObjectContext = {
        
        let coordinator = self.persistentStoreCoordinator
        let context = NSManagedObjectContext()
        context.persistentStoreCoordinator = coordinator
        return context

    }()
    
    lazy var lazyManagedObjectModel : NSManagedObjectModel = {
        let managedObjecModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])
        return managedObjecModel!
    }()
    
    lazy var persistentStoreCoordinator : NSPersistentStoreCoordinator = {
        var coordinator : NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel:lazyManagedObjectModel)
        do {// sava in memory
            try coordinator!.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            coordinator = nil
            print("Error")
        }
        return coordinator!
    }()
    
    var managedObjectContext : NSManagedObjectContext {
        return lazyManagedObjectContext
    }
}
