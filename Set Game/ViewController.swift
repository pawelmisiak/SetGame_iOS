//
//  ViewController.swift
//  Set Game
//
//  Created by Pawel Misiak on 10/1/18.
//  Copyright © 2018 Pawel Misiak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
    func populateGameArray() {
        var symbols = ["∆","○","□"]
        var count = [1,2,3]
        var colors = ["red", "green", "blue"]
        var shading = ["full","striped","empty"]
        
    }

    @IBAction func touchCard(_ sender: UIButton) {
        highlight(withSymbol: "⭕️", on: sender)
    }
    
    func highlight(withSymbol symbol: String, on button: UIButton) {
        button.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
    }
    
    @IBOutlet var buttonArray: [UIButton]!
}
