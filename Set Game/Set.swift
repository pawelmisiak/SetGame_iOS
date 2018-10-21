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
    var arrayOfMatchedCardIndices = Array<Int>()
    var cardsSelected = Array<Card>()
    var score = Int()
    var weGotAMatch = false
    var wrongMatch = false
    
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
    func matchingSymbolCount(card1: Card, card2: Card,card3: Card) -> Bool{
        if card1.symbolCount == card2.symbolCount && card2.symbolCount == card3.symbolCount {
            return true
        }
        if card1.symbolCount != card2.symbolCount && card2.symbolCount != card3.symbolCount && card1.symbolCount != card3.symbolCount {
            return true
        }
        return false
    }
    
    func matchingFunction(first: String, second: String, third: String) -> Bool{
        
        if first == second && second == third {
            return true
        }
        if first != second && second != third && first != third {
            return true
        }
        
        return false
    }
    
    func checkForMatch(card1: Card, card2: Card,card3: Card) -> Bool{
        if matchingFunction(first: card1.color, second: card2.color, third: card3.color) &&
            matchingFunction(first: card1.shade, second: card2.shade, third: card3.shade) &&
            matchingFunction(first: card1.symbol, second: card2.symbol, third: card3.symbol) &&
            matchingSymbolCount(card1: card1, card2: card2, card3: card3){
            weGotAMatch = true
            return true
        }else {
            wrongMatch = true
            return false
        }
    }
    
    func returnIndices(cardArr: [Card]) -> [Int]{
        return [cardArr[0].cardIndex, cardArr[1].cardIndex, cardArr[2].cardIndex]
    }
    
    func chooseCard(at index: Int) {
        let currentCard = cardsOnTable[index]
        
        if cardsSelected.contains(currentCard){
            score -= 1
            cardsOnTable[index].isSelected = false
            cardsSelected = cardsSelected.filter{ $0 != currentCard }
            return
        }
        
        if cardsSelected.count < 3 {
            cardsOnTable[index].isSelected = true
            cardsOnTable[index].cardIndex = index
            cardsSelected.append(cardsOnTable[index])
            
            
        } else {
            deselectAll()
            chooseCard(at: index) // use recursion to automatically select another button without need of pressing on the button twice
        }
        if cardsSelected.count == 3 {
            let card1 = cardsSelected[0]
            let card2 = cardsSelected[1]
            let card3 = cardsSelected[2]
            checkForMatch(card1: card1, card2: card2, card3: card3)
            arrayOfMatchedCardIndices = returnIndices(cardArr: cardsSelected)
            deselectAll()
        
//        if cardsSelected.count <= 3 && wrongMatch == true {
//
        }
    }
    
    func peak() {
        
    }
    
    init() {
        self.addCardsToArray(numOfCards: 81)
        self.createEmptyArrayOfCards()
        self.score = 0
        self.weGotAMatch = false
        self.wrongMatch = false
        
        
//         randomize
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
