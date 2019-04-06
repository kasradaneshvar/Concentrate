//
//  ViewController.swift
//  Concentrate
//
//  Created by Kasra Daneshvar on 4/5/19.
//  Copyright © 2019 Kasra Daneshvar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Model
    lazy var game: Concentrate = Concentrate(numberOfPairsOfCards: cardButtons.count / 2)
    
    // MARK: Properties
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips = \(flipCount)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: Actions
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            flipCount = 0
        }
    }
    

    // MARK: Supporting functions
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6000000238) : #colorLiteral(red: 0.9850024288, green: 0.6463856413, blue: 0.001579543076, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["🎃", "👻" , "🦇", "🙀", "⚰️", "🍬", "🍭", "😱"]

    var emoji = [Int:String]()
    func emoji(for card: Card) -> String {
        //👍🏿 way to do a back-to-back if
        if emoji[card.identifier] == nil ,emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        // 👍🏿 way to return an optional.
        return emoji[card.identifier] ?? "?"
    }
    
    
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


