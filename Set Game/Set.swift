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
    
    private func addCardsToArray(numOfCards: Int){
        var card = Card()
        var symbols = ["▲","●","■"]
        var symbolCounts = [1,2,3]
        var colors = ["red", "green", "blue"]
        var shadings = ["full","striped","empty"]
     
        for i in 0..<3 {
            for j in 0..<3 {
                for k in 0..<3 {
                    for l in 0..<3 {
                        card.symbol = symbols[i]
                        card.symbolCount = symbolCounts[j]
                        card.color = colors[k]
                        card.shade = shadings[l]
                        cards += [card]
                    }
                }
            }
        }
    }
    
    func chooseCard(at index: Int) {
        print(cards[index])
        
    }
    
    init() {
        addCardsToArray(numOfCards: 81)
        var decreasingIterator = cards.count-1
        while decreasingIterator > 0 {
            let rand = Int(arc4random_uniform(UInt32(decreasingIterator)))
            cards.swapAt(decreasingIterator, rand)
            decreasingIterator -= 1
        }
    }
}
