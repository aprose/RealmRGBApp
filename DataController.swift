//
//  File.swift
//  RGBBullsEyeApp
//
//  Created by Adrian Rose on 01.12.21.
//

import Foundation
import RealmSwift
import Realm


class QsTask: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var owner: String = ""
    @Persisted var status: String = ""

    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}


class DataController: NSObject {
    
    let app =  RealmSwift.App(id: "YOUR_REALM_APP_ID")
    
    // Collections
    
    let tasksCurrent: Results<QsTask>? = nil
    
    // Observations . Notification Token
    // Once finished observing then call token.invalidate()
    var token: NotificationToken?
    
    override init() {
        // SetUp Controller with login observing
     
        app.login(credentials: Credentials.anonymous) { (result) in
            
            switch result {
            case .failure(let error):
                print("login failed: \(error)")
            case .success(let user):
                print("login succeeded: \(user)")
            }
            
        }
        
        // Lets Observe the Notifications
        
        token = tasksCurrent?.observe(on: nil, { changes in
            
            switch changes {
            case .initial(_):
                break
            case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                // Query results have changed
                print("Deleted indices :  \(deletions)")
                print("Inserted indices : \(insertions)")
                print("Modified modifications : \(modifications)")

                break
            case .error(let error):
                // error occurred while opening Realm file
                print("An error occurred \(error)")
                break
            }
            
            
        })
        
        // Handle Logging out
        
        app.currentUser?.logOut { (error) in
            
            // Handle logging out a User by cleaning up
            
            
            
        }
        
        
    }
    
    func addATaskToRealm() {
        
        let task = QsTask(name: "Do Laundry")
        
        let config = Realm.Configuration.defaultConfiguration

        
        let realm = try! Realm(configuration: config, queue: nil)
        
        try! realm.write {
            realm.add(task)
        }
            
    }
    
    func getAllTasks() {
        
        let tasks = try! Realm(configuration: .defaultConfiguration, queue: nil).objects(QsTask.self)

        let tasksInProgress = tasks.where { tasks in
            tasks.status == "InProgress"
        }
        
        print("A list of tasks in progress: \(tasksInProgress.description)")
    }
    
    func setUpRealm() {

        // Instantiate the class. For convenience, you can initialize
        // objects from dictionaries with appropriate keys and values.
        let dog = Dog(value: ["name": "Max", "age": 5])
        
        let config = Realm.Configuration.defaultConfiguration
        let file = config.fileURL?.path ?? ""
        print("path is : \(file)")

        let realm = try! Realm(configuration: config, queue: nil)
        // Open a thread-safe transaction.
        try! realm.write {
            // Add the instance to the realm.
            realm.add(dog)
            print("Addded Dog")
        }
    }

    
}
