//
//  CoreDataHandler.swift
//  banquemisr.challenge05
//
//  Created by Momen Zarad on 16/03/2024.
//

import Foundation
import CoreData

class CoreDataHandler {
    public static var shared = CoreDataHandler()
    lazy var persistentContainer: NSPersistentContainer = {
        let modelURL = Bundle(for: type(of: self)).url(forResource: "MovieInfo", withExtension: "momd")!
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
        let container = NSPersistentContainer(name: "MovieInfo", managedObjectModel: managedObjectModel!)
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var context: NSManagedObjectContext = persistentContainer.viewContext

    // MARK: - Core Data Saving support
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    public func insert(_ movies: [MovieInfoModel]) {
        for movie in movies {
            let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context)
            let newRequest = NSManagedObject(entity: entity!, insertInto: context)
            newRequest.setValue(movie.id, forKey: "id")
            newRequest.setValue(movie.index, forKey: "index")
            newRequest.setValue(movie.title, forKey: "title")
            newRequest.setValue(movie.posterImage, forKey: "posterImage")
            newRequest.setValue(movie.releaseDate, forKey: "releaseDate")
            newRequest.setValue(movie.genre, forKey: "genre")
            newRequest.setValue(movie.overview, forKey: "overview")
            newRequest.setValue(movie.runtime, forKey: "runtime")
        }
        saveContext()
    }
    
    public func fetchMovieDetails(with index: Int) -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        let idPredicate = NSPredicate(format: "id == %d", index)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [idPredicate])
        request.predicate = predicate
        request.returnsObjectsAsFaults = false

        do {
            let result = try context.fetch(request)
            return result as! [NSManagedObject]
        } catch {
            return []
        }
    }

    public func fetchAllMovies(with index: Int) -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        let indexPredicate = NSPredicate(format: "index == %d", index)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [indexPredicate])
        request.predicate = predicate
        request.returnsObjectsAsFaults = false

        do {
            let result = try context.fetch(request)
            return result as! [NSManagedObject]
        } catch {
            return []
        }
    }

    public func deleteItem(with index: Int) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        request.predicate = NSPredicate(format: "index == %d", index)
        do {
            let result = try context.fetch(request) as! [NSManagedObject]
            result.forEach { context.delete($0) }
            saveContext()
        } catch {}
    }

    public func DeleteAllData() {
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "Movie"))
        do {
            try context.execute(DelAllReqVar)
        } catch {}
    }

    func getMoviesCount() -> Int {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        do {
            let count = try context.count(for: fetchRequest)
            return count
        } catch {
            return 0
        }
    }
}
