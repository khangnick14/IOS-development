/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Nguyen Manh Khang
  ID: s3864131
  Created  date: 15/08/2022
  Last modified: 29/08/2022
  Acknowledgement:
 https://developer.apple.com/documentation/coredata
 https://www.advancedswift.com/fetch-requests-core-data-swift/
 https://cocoacasts.com/adding-core-data-to-an-existing-swift-project-fetching-data-from-a-persistent-store
 https://www.hackingwithswift.com/forums/swiftui/playing-sound/4921
 https://www.hackingwithswift.com/quick-start/swiftui/how-to-use-environmentobject-to-share-data-between-views
 https://www.youtube.com/watch?v=cpg7f4pVzFw
*/

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "DataModel")

    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Can't load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Successfully save player!")
        } catch {
            print("Can't save player")
        }
    }
    
    func addPlayer(name: String, score: Int32, achievement: String, context: NSManagedObjectContext) {
        let player = Player(context: context)
        player.id = UUID()
        player.name = name
        player.score = score
        player.achievement = achievement
        save(context: context)
    }
    
    func updatePlayer(player: Player, name:String, score: Int32, achievement: String, context:NSManagedObjectContext) {
        player.name = name
        player.score = score
        player.achievement = achievement
        save(context: context)
    }
    
    func fetchPlayerByName(name:String, context: NSManagedObjectContext) -> Player{
        let fetchRequest: NSFetchRequest<Player>
        fetchRequest = Player.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "name LIKE %@", name)
        do {
            let player = try context.fetch(fetchRequest).first!
            return player
        } catch {
            print("error")
            return Player()
        }
    }
}
