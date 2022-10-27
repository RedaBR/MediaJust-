//
//  CoreDataMediaJustTests.swift
//  MediaJustTests
//
//  Created by Reda on 20/10/2022.
//

import XCTest
import CoreData
@testable import MediaJust
// MARK: - Test Core Data Media Just
class CoreDataMediaJustTests: XCTestCase {

    func testGetMedia() {
// Given
        let properties = Article(context: CoreDataStack.sharedInstance.viewContext)
        properties.title = "toto"
        do {
// When
        try MockCoreData().lazyManagedObjectContext.save()
            }
        catch {
        }
        CoreDataStack.sharedInstance.getProperties { (media) in
// Then
            XCTAssertEqual(media.count>0, properties.title == "toto")
        }
    }

    func testDeleteMedia() {
// Given
        let properties = Article(context: CoreDataStack.sharedInstance.viewContext)
        properties.title = "toto"
        var object = Article()
        do {
// When
            try MockCoreData().lazyManagedObjectContext.save()
        }
        catch {
        }
        CoreDataStack.sharedInstance.getPropertieWithTitle(title: properties.title!) { (media) in
            object = media.first!
            CoreDataStack.sharedInstance.delete(articleToDelete: object)
// Then 
            XCTAssertFalse(media.first?.title == "toto")
        }
    }
}
