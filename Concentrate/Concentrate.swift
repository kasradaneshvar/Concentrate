//
//  Concentrate.swift
//  Concentrate
//
//  Created by Kasra Daneshvar on 4/6/19.
//  Copyright © 2019 Kasra Daneshvar. All rights reserved.
//

import Foundation

class Concentrate {
    
    // MARK: Properties
    var cards = [Card]()
    
    // MARK: Methods
    func chooseCard(at index: Int) {
        if cards[index].isFaceUp {
            cards[index].isFaceUp = false
        } else {
            cards[index].isFaceUp = true
        }
    }
    
    // MARK: Initializer.
    // This only takes the number of pairs of cards and it has to initialize `cards` with that many cards of unique identifiers.
    // ❓: Is it possible to just pass the `nubmerOfPairs...` to the Array initializer and have it take care of initializing the cards?
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        // TODO: Shuffle the cards.
    }
}
