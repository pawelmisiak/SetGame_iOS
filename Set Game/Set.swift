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
    var cardsOnTable = Array<Card>()
    var cardsChosen = 0
    var cardsSelected = Array<Card>()
    
    private func createEmptyArrayOfCards(){
        for _ in 0...23{
            cardsOnTable.append(Card())
        }
    }
    
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
        if cardsSelected.count < 3 {
            cardsOnTable[index].isSelected = true
            cardsSelected.append(cardsOnTable[index])
        } else {
            
        }
        print(cardsSelected.count)
    }
    
    init() {
        self.addCardsToArray(numOfCards: 81)
        self.cardsChosen = 0
        self.createEmptyArrayOfCards()
        
        // randomize
        var decreasingIterator = cards.count-1
        while decreasingIterator > 0 {
            let rand = Int(arc4random_uniform(UInt32(decreasingIterator)))
            cards.swapAt(decreasingIterator, rand)
            decreasingIterator -= 1
        }
    }
}
