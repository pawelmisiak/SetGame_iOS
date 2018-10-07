//
//  ViewController.swift
//  Set Game
//
//  Created by Pawel Misiak on 10/1/18.
//  Copyright © 2018 Pawel Misiak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var iterator = 0
    @IBOutlet var buttonArray: [UIButton]!
    @IBAction func touchCard(_ sender: UIButton) {
        highlight(withSymbol: "⭕️", on: sender)
        if let cardNumber = buttonArray.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel();
        } else {
            print("Chosen card isn't in the cardButtons")
        }
        updateViewFromModel();
    }
    
    private lazy var game = Set()


  
    
    func highlight(withSymbol symbol: String, on button: UIButton) {
        button.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
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
        
        button.setTitle(title, for: UIControl.State.normal)
        
        switch card.color {
        case "red":
            button.setTitleColor(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), for: UIControl.State.normal)
        case "green":
            button.setTitleColor(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), for: UIControl.State.normal)
        default:
            button.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: UIControl.State.normal)
        }
        return button
    }
    
    private func updateViewFromModel() {
        for index in buttonArray.indices {
            var currentButton = buttonArray[index]
            let currentCard = game.cards[index]
            let title = currentCard.symbol + currentCard.color + currentCard.shade
            currentButton = colorTheButton(card: currentCard, button: currentButton)
        }
    }
}
