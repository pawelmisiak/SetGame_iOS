//
//  Set.swift
//  Set Game
//
//  Created by Pawel Misiak on 10/1/18.
//  Copyright © 2018 Pawel Misiak. All rights reserved.
//

import Foundation

class Set {
    var cards = Array<Card>()
    
    func chooseCard(at index: Int) {
        
    }
    
    init(cardsInDeck: Int) {
        for _ in 0..<cardsInDeck { // underscore says there is no var associated with this loop
            let card = Card()
            cards += [card]
        }
    }
}
