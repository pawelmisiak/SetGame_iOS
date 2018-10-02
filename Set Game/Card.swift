//
//  Card.swift
//  Set Game
//
//  Created by Pawel Misiak on 10/1/18.
//  Copyright © 2018 Pawel Misiak. All rights reserved.
//

import Foundation

struct Card {
    
    var isMatched = false
    var isSelected = false
    var identifier: Int
    
    private static var uniqueID = 0
    
    private static func getUniqueID() -> Int {
        uniqueID += 1
        
        return uniqueID
    }
    
    init() {
        self.identifier = Card.getUniqueID()
    }
}
