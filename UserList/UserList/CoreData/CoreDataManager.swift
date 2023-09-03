//
//  CoreDataManager.swift
//  UserList
//
//  Created by Hoang Linh Nguyen on 5/9/2023.
//

import CoreData

class CoreDataManager {
    let request = Favourite.fetchRequest()
    
    static let shared = CoreDataManager()

    private init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UserListCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    } ()
    
    func getAllItems() {
        let context = persistentContainer.viewContext
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for result in results {
                if let fav = result as? Favourite {
                    favourites.append(fav)
                }
            }
        }
        catch {
            print("Fetch failed")
        }
    }
    
    func saveItem(favouriteUserInfo: [String: String]) {
        let context = persistentContainer.viewContext
        if let entity = NSEntityDescription.entity(forEntityName: "Favourite", in: context) {
            let newFavourite = Favourite(entity: entity, insertInto: context)
            newFavourite.image = favouriteUserInfo["image"]
            newFavourite.name = favouriteUserInfo["name"]
            newFavourite.link = favouriteUserInfo["link"]
            do {
                try context.save()
                favourites.append(newFavourite)
            }
            catch {
                print("Context save error")
            }
        }
    }
    
    func deleteAllItems() {
        let context = persistentContainer.viewContext
        request.returnsObjectsAsFaults = false
        do {
            let results: NSArray = try context.fetch(request) as NSArray
            for managedObject in results {
                if let managedObjectData: NSManagedObject = managedObject as? NSManagedObject {
                    context.delete(managedObjectData)
                    try context.save()
                }
            }
        } catch let error as NSError {
            print("Detele all data in Favourite error : \(error) \(error.userInfo)")
        }
    }
}
