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
    
    private func deselectAll() {
        for index in 0..<cardsOnTable.count {
            cardsOnTable[index].isSelected = false
        }
        cardsSelected.removeAll()
    }
    func matchingColors(card1: Card, card2: Card,card3: Card) -> Bool{
        if card1.color == card2.color && card2.color == card3.color {
            return true
        }
        return false
    }
    func matchingSymbol(card1: Card, card2: Card,card3: Card) -> Bool{
        if card1.symbol == card2.symbol && card2.symbol == card3.symbol {
            return true
        }
        return false
    }
    func matchingSymbolCount(card1: Card, card2: Card,card3: Card) -> Bool{
        if card1.symbolCount == card2.symbolCount && card2.symbolCount == card3.symbolCount {
            return true
        }
        return false
    }
    func matchingShade(card1: Card, card2: Card,card3: Card) -> Bool{
        if card1.shade == card2.shade && card2.shade == card3.shade {
            return true
        }
        return false
    }
    
    func checkForMatch() {
        
    }
    
    func chooseCard(at index: Int) {
        var currentCard = cardsOnTable[index]
        
        if cardsSelected.contains(currentCard){
            cardsOnTable[index].isSelected = false
            cardsSelected = cardsSelected.filter{ $0 != currentCard }
            print(cardsSelected.count)
            return
        }
        
        if cardsSelected.count < 3 {
                cardsOnTable[index].isSelected = true
                cardsSelected.append(cardsOnTable[index])
            
        } else {
            deselectAll()
            chooseCard(at: index) // use recursion to automatically select another button without need of pressing on the button twice
        }
        if cardsSelected.count == 3 {
            checkForMatch()
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

extension Card: Equatable {
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.color == rhs.color && lhs.symbol == rhs.symbol && lhs.shade == rhs.shade && lhs.symbolCount == rhs.symbolCount
    }
}
