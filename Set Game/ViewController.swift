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
    
    private lazy var game = Set()
    var visibleButtons = 12
    
    
    
    @IBOutlet var buttonArray: [UIButton]!
    @IBAction func touchCard(_ sender: UIButton) {
        highlight(withSymbol: "", on: sender)
        if let cardNumber = buttonArray.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel();
        } else {
            print("Chosen card isn't in the cardButtons")
        }
        updateViewFromModel();
    }

    @IBAction func addThree(_ sender: UIButton) {
        visibleButtons += 3
        updateViewFromModel()
        if visibleButtons == 24 {
            sender.isEnabled = false
            sender.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        }
    }
    
    @IBAction func reset() {
        for index in buttonArray.indices {
            buttonArray[index].setTitle(" ", for: UIControl.State.normal)
            buttonArray[index].backgroundColor = UIColor.white
        }
        game = Set()
        visibleButtons = 12
        viewDidLoad()
    }
    
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
        for index in 0..<visibleButtons {
            var currentButton = buttonArray[index]
            if currentButton.backgroundColor == UIColor.white {
                currentButton.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
                currentButton.isEnabled = true
            }
            if currentButton.currentTitle == " " {
                let currentCard = game.cards.remove(at: 0)
                currentButton = colorTheButton(card: currentCard, button: currentButton)
            }
        }
    }
}
