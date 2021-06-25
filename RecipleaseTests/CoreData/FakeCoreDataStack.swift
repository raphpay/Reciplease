//
//  CoreDataStackFake.swift
//  RecipleaseTests
//
//  Created by Raphaël Payet on 25/06/2021.
//

import Foundation
import CoreData
import Reciplease

class FakeCoreDataStack: CoreDataStack {
    override init() {
        super.init()
        
        // We create here an in memory store
        let persistentStoreDescription = NSPersistentStoreDescription()
        persistentStoreDescription.type = NSInMemoryStoreType
        
        let container = NSPersistentContainer(
            name: "CoreDataApp",
            managedObjectModel: CoreDataStack.model)
        container.persistentStoreDescriptions = [persistentStoreDescription]
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        persistantContainer = container
    }
}
