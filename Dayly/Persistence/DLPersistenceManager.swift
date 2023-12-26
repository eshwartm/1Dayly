//
//  DLPersistenceManager.swift
//  Dayly
//
//  Created by Eshwar Ramesh on 26/12/23.
//

import Foundation
//import Realm


class DLPersistenceManager {
    
//    var realmDB: RealmInstance
    
    var dateTaskStatus = [Date: [UUID: Bool]]()
    
    func fetchTaskAndDates() -> [Date: [DLTask]] {
        
        return [:]
    }
}


