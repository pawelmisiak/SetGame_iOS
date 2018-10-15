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
    var symbol: String
    var symbolCount: Int
    var color: String
    var shade: String
    
    init() {
        self.symbol = ""
        self.symbolCount = 0
        self.color = ""
        self.shade = ""
    }
}
