//
//  File.swift
//  testAppPlayground
//
//  Created by Adrian Rose on 27.11.21.
//

import Foundation
import RealmSwift

class DogToy: Object {
    @Persisted var name = ""
}

class Dog: Object {
    @Persisted(primaryKey: true) var name = ""
    @Persisted var age = 0
    @Persisted var color = ""
    @Persisted var currentCity = ""

    // To-one relationship
   // @Persisted var favoriteToy: DogToy?
}


