//
//  CoreDataMediaJustTests.swift
//  MediaJustTests
//
//  Created by Reda on 20/10/2022.
//

import XCTest
import CoreData
@testable import MediaJust

class CoreDataMediaJustTests: XCTestCase {

    func testGetMedia() {
        let properties = Article(context: CoreDataStack.sharedInstance.viewContext)
        
        properties.title = "toto"
         
        do {
            try MockCoreData().lazyManagedObjectContext.save()
        }
        catch {
            
        }
        
        CoreDataStack.sharedInstance.getProperties { (media) in
            XCTAssertEqual(media.count>0, properties.title == "toto")
        }
    }

    
    func testDeleteMedia() {
        let properties = Article(context: CoreDataStack.sharedInstance.viewContext)
        
        properties.title = "toto"
        var object = Article()
        do {
            try MockCoreData().lazyManagedObjectContext.save()
        }
        catch {
            
        }
        
        CoreDataStack.sharedInstance.getPropertieWithTitle(title: properties.title!) { (media) in
            object = media.first!
            CoreDataStack.sharedInstance.delete(articleToDelete: object)
            
            XCTAssertFalse(media.first?.title == "toto")
        }
        
    }
}
