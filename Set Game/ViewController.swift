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
    
    @IBOutlet var buttonArray: [UIButton]!
    @IBOutlet weak var addThree: UIButton!
    @IBAction func addThree(_ sender: UIButton) {
        visibleButtons += 3
        if visibleButtons == 24 {
            sender.isEnabled = false
            sender.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        }
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
//        highlight(on: sender)
        if let cardNumber = buttonArray.index(of: sender) {
            game.chooseCard(at: cardNumber)
            if game.arrayOfMatchedCardIndices.count == 3 {
                for index in game.arrayOfMatchedCardIndices {
                    buttonArray[index].setTitle(" ", for: UIControl.State.normal)
                    game.arrayOfMatchedCardIndices.removeAll()
                }
            }
            updateViewFromModel();
        } else {
            print("Chosen card isn't in the cardButtons")
        }
        updateViewFromModel();
    }

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
    
    private func updateViewFromModel() {
        
        for index in 0..<visibleButtons {
            var currentButton = buttonArray[index]
            let currentCard = game.cardsOnTable[index]
            if currentCard.isSelected {
                currentButton.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
            } else {
                currentButton.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }
            currentButton.isEnabled = true

            if currentButton.currentTitle == " " {
                game.cardsOnTable[index] = game.cards[0]
                let currentCard = game.cards.remove(at: 0)
                currentButton = colorTheButton(card: currentCard, button: currentButton)
            }
        }
    }
}
