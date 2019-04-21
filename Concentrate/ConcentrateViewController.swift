//
//  ViewController.swift
//  Concentrate
//
//  Created by Kasra Daneshvar on 4/5/19.
//  Copyright © 2019 Kasra Daneshvar. All rights reserved.
//

import UIKit

class ConcentrateViewController: VCLLoggingViewController {

    override var vclLoggingName: String {
        return "Game"
    }
    // MARK: Model
    private lazy var game: Concentrate = Concentrate(numberOfPairsOfCards: numberOfPairsOfCards)

    // MARK: Properties
    var numberOfPairsOfCards: Int {
        // get {
            return (visibleCardbuttons.count + 1) / 2
        // }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    private var visibleCardbuttons: [UIButton]! {  // For `autolayout` hiding.
        return cardButtons?.filter { !$0.superview!.isHidden }
    }
    
    override func viewDidLayoutSubviews() { // To solve an issue where hiding stacks would remove the flipped card from the new layout.
        super.viewDidLayoutSubviews()
        updateViewFromModel()
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key:Any]  = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString( // Edit: add `traitCollection` to have different formats for different oriantations.
            string: traitCollection.verticalSizeClass == .compact ? "Flips:\n\(flipCount)" : "Flips: \(flipCount)",
            attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) { // ↑ That won't work unless we get notified that the `traitCollection` changed.
        super.traitCollectionDidChange(previousTraitCollection)
        updateFlipCountLabel()
    }

    // MARK: Actions
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = visibleCardbuttons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            flipCount = 0
        }
    }
    
    // MARK: Supporting functions
    private func updateViewFromModel() {
        if visibleCardbuttons != nil { // Because `prepare` does not set outlets
            for index in visibleCardbuttons.indices {
                let button = visibleCardbuttons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControl.State.normal)
                    button.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
                } else {
                    button.setTitle("", for: UIControl.State.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6000000238) : #colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1)
                }
            }
        }
    }
    
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }

    private var emojiChoices = "🎃👻🦇🙀⚰️🍬🍭😱"

    private var emoji = [Card:String]()
    private func emoji(for card: Card) -> String {
        //👍🏿 way to do a back-to-back if
        if emoji[card] == nil ,emojiChoices.count > 0 {
            let randomIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomIndex))
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
