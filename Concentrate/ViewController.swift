//
//  ViewController.swift
//  Concentrate
//
//  Created by Kasra Daneshvar on 4/5/19.
//  Copyright © 2019 Kasra Daneshvar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Properties
    @IBOutlet var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of)
        flipCard(withEmoji: "👻", on: sender)
    }
    
    @IBAction func touchSecondCard(_ sender: UIButton) {
        flipCard(withEmoji: "🎃", on: sender)
    }
    //
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.9850024288, green: 0.6463856413, blue: 0.001579543076, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
    }
    
}


