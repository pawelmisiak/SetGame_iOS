//
//  ViewController.swift
//  Set Game
//
//  Created by Pawel Misiak on 10/1/18.
//  Copyright © 2018 Pawel Misiak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
        for i in visibleButtons..<buttonArray.count { // disable the hidden buttons and disable them
            buttonArray[i].isEnabled = false
        }
    }
    
    @IBAction func reset() {
        for index in buttonArray.indices {
            buttonArray[index].setTitle(" ", for: UIControl.State.normal)
            buttonArray[index].backgroundColor = UIColor.clear
            buttonArray[index].setAttributedTitle(nil, for: UIControl.State.normal)
        }
        addThree.isEnabled = true
        addThree.backgroundColor = #colorLiteral(red: 1, green: 0.09332232228, blue: 0, alpha: 1)
        game = Set()
        visibleButtons = 12
        viewDidLoad()
    }
    
    private lazy var game = Set()
    var visibleButtons = 12
    var peackedCard = Array<Card>()
    
    @IBOutlet var buttonArray: [UIButton]!
    @IBOutlet weak var addThree: UIButton!
    @IBAction func addThree(_ sender: UIButton) {
        visibleButtons += 3
        updateViewFromModel()
    }
    
    
    @IBAction func peakButton(_ sender: UIButton) {
        game.score -= 4
        var found = false
        for i in 0..<visibleButtons{
            for j in i+1..<visibleButtons{
                for k in j+1..<visibleButtons{
                    if game.checkForMatch(
                        card1: game.cardsOnTable[i],
                        card2: game.cardsOnTable[j],
                        card3: game.cardsOnTable[k]) {
                        print(i, j, k)
                        found = true
                        buttonArray[i].backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                        buttonArray[j].backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                        buttonArray[k].backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                        ScoreCount.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                            self.updateViewFromModel()
                        })
                    }
                    if found{
                        break
                    }
                }
                if found{
                    break
                }
            }
            if found{
                break
            }
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
//        highlight(on: sender)
        if let cardNumber = buttonArray.index(of: sender) {
            game.chooseCard(at: cardNumber)
            if game.arrayOfMatchedCardIndices.count == 3 {
                for index in game.arrayOfMatchedCardIndices {
                    if game.weGotAMatch{
                        buttonArray[index].setTitle(" ", for: UIControl.State.normal)
                        buttonArray[index].backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
                        ScoreCount.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//                        game.score += 3
                    }
                    if game.wrongMatch{
//                        game.score -= 3
                        buttonArray[index].backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
                        ScoreCount.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
                        game.cardsOnTable[index].isSelected = false
                    }
                }
                game.arrayOfMatchedCardIndices.removeAll()
            }
            updateViewFromModel();
        } else {
            print("Chosen card isn't in the cardButtons")
        }
        updateViewFromModel();
    }
    @IBOutlet weak var ScoreCount: UILabel!
    
    func colorTheButton(card: Card,button: UIButton) -> UIButton {
        var title = card.symbol
        switch card.symbolCount {
        case 2:
            title = title + title
        case 3:
            title = title + title + title
        default:
            break
        }
        
        var outlineColor: UIColor
        var fillColor: UIColor
        
        switch card.color {
        case "red": outlineColor = UIColor.red
        case "green": outlineColor = UIColor.green
        case "blue": outlineColor = UIColor.blue
        default:
            outlineColor = UIColor.white
        }
        
        fillColor = outlineColor
        
        switch card.shade{
        case "full": fillColor = fillColor.withAlphaComponent(1)
        case "striped": fillColor = fillColor.withAlphaComponent(0.3)
        case "empty": fillColor = fillColor.withAlphaComponent(0.0)
        default:
            break
        }
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: fillColor,
            .strokeColor: outlineColor,
            .strokeWidth: -5.0
        ]
        
        let newString = NSAttributedString(string: title, attributes: attributes)
        button.setAttributedTitle(newString, for: UIControl.State.normal)
        button.setTitle(title, for: UIControl.State.normal)
        return button
    }
    
    func checkIfAllDisabled() -> Bool{
        for index in 0..<visibleButtons{
            if buttonArray[index].isEnabled == true {
                return false
            }
        }
        return true
    }
    
    private func updateViewFromModel() {
        ScoreCount.text = "Score: \(game.score)"
        
        if checkIfAllDisabled() {
            ScoreCount.text = "You have finished the game with score: \(game.score)"
        }
        
        print(game.cards.count)
        print(game.cardsOnTable.count)
        if game.cards.count < 3 || visibleButtons == 24{
            addThree.isEnabled = false
            addThree.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        }
        for index in 0..<visibleButtons {
            if game.weGotAMatch == false && game.wrongMatch == false {
                
            var currentButton = buttonArray[index]
            let currentCard = game.cardsOnTable[index]
            if currentCard.isSelected {
                currentButton.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
            } else {
                currentButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            }
            currentButton.isEnabled = true

            if currentButton.currentTitle == " " {
                if game.cards.count == 0 {
                    currentButton.isEnabled = false
                    currentButton.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                } else {
                    game.cardsOnTable[index] = game.cards[0]
                    let currentCard = game.cards.remove(at: 0)
                    currentButton = colorTheButton(card: currentCard, button: currentButton)
                }
            }
            }
        }
        if game.weGotAMatch || game.wrongMatch {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self.ScoreCount.backgroundColor = UIColor.clear
                if self.game.weGotAMatch {
                    self.game.score += 3
                }
                if self.game.wrongMatch {
                    self.game.score -= 3
                }
                self.game.weGotAMatch = false
                self.game.wrongMatch = false
                self.updateViewFromModel()
            })
        }
    }
}
