import SwiftUI
import RealmSwift

struct ContentView: View {
    
    
    
    var body: some View {
        
        VStack {
            
            Color(red: 0.5, green: 0.5, blue: 0.5)
            Text("R: ??? G: ??? B: ???")
                .padding()
            Button("Realm Setup") {
                // setUpRealm()
            }

        }
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

