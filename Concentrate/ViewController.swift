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
    private lazy var game: Concentrate = Concentrate(numberOfPairsOfCards: numberOfPairsOfCards)

    // MARK: Properties
    var numberOfPairsOfCards: Int {
        // get {
            return (cardButtons.count + 1) / 2
        // }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips = \(flipCount)"
        }
    }

    // MARK: Actions
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            flipCount = 0
        }
    }
    

    // MARK: Supporting functions
    private func updateViewFromModel() {
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
    
    private var emojiChoices = ["🎃", "👻" , "🦇", "🙀", "⚰️", "🍬", "🍭", "😱"]

    private var emoji = [Card:String]()
    private func emoji(for card: Card) -> String {
        //👍🏿 way to do a back-to-back if
        if emoji[card] == nil ,emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        // 👍🏿 way to return an optional.
        return emoji[card] ?? "?"
    }
    
    
    private func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 0.9850024288, green: 0.6463856413, blue: 0.001579543076, alpha: 1)
        } else {
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(-self)))
        } else {
            return 0
        }
    }
}
