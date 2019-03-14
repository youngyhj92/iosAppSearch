//
//  AppleSearchDBManager.swift
//  appleAppSearch
//
//  Created by 양현준 on 11/03/2019.
//  Copyright © 2019 hyunjun yang. All rights reserved.
//

import UIKit
import RealmSwift

class History : Object  {
    @objc dynamic var historyTitle = ""
}

class DatabaseProces  {
    
    let realm : Realm
    
    init() {
        realm = try! Realm()
    }
    
    func writeDatabase(value : Object)  {
        try! realm.write {
            realm.add(value)
        }
    }
    
    func deleteDatabase(value : Object)  {
        try! realm.write {
            realm.delete(value)
        }
    }
    
    func initializeDatabase()  {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    
}
