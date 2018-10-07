//
//  ViewController.swift
//  Set Game
//
//  Created by Pawel Misiak on 10/1/18.
//  Copyright © 2018 Pawel Misiak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var buttonArray: [UIButton]!
    @IBAction func touchCard(_ sender: UIButton) {
        highlight(withSymbol: "⭕️", on: sender)
    }
    
//    private lazy var game = Set(cardsInDeck: 81)


  
    
    func highlight(withSymbol symbol: String, on button: UIButton) {
        button.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
    }
    
    private func updateViewFromModel() {
//        for index in buttonArray.indices {
//            let button = buttonArray[index]
//
//        }
    }
}
