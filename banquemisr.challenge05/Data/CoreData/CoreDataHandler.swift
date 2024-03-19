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
    
    public func insert(_ movies: [MoviesEntity], type: String) {
        for movie in movies {
            // Check if an object with the same ID already exists
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Movie")
            fetchRequest.predicate = NSPredicate(format: "id == %d AND type == %@", movie.movieID, type)
            do {
                let results = try context.fetch(fetchRequest)
                if results.first is NSManagedObject {
                    //print("Movie with ID \(movie.movieID) already exists. Skipping insertion.")
                    continue
                } else {
                    let entity = NSEntityDescription.entity(forEntityName: "Movie", in: context)!
                    let newRequest = NSManagedObject(entity: entity, insertInto: context)
                    newRequest.setValue(type, forKey: "type")
                    newRequest.setValue(movie.movieID, forKey: "id")
                    newRequest.setValue(movie.movieTitle, forKey: "title")
                    newRequest.setValue(movie.moviePosterImage, forKey: "posterImage")
                    newRequest.setValue(movie.movieReleaseDate, forKey: "releaseDate")
                }
            } catch {
                print("Error fetching existing movie with ID \(movie.movieID): \(error)")
            }
        }
        saveContext()
    }
    
    public func insertMovieDetails(with id: Int, details: MovieDetailsEntity) {
        // Check if an object with the specified ID exists
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Movie")
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
        do {
            let results = try context.fetch(fetchRequest)
            guard let movie = results.first as? NSManagedObject else {
                print("No movie found with ID \(id)")
                return
            }
            movie.setValue(details.movieGenres, forKey: "genre")
            movie.setValue(details.movieOverview, forKey: "overview")
            movie.setValue(details.movieRunTime, forKey: "runtime")
            saveContext()
        } catch {
            print("Error updating movie with ID \(id): \(error)")
        }
    }
    
    public func fetchAllMovies(with type: String) -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        let indexPredicate = NSPredicate(format: "type == %@", type)
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
    
    public func fetchMovieDetails(with id: Int) -> [NSManagedObject] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        let idPredicate = NSPredicate(format: "id == %d", id)
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
