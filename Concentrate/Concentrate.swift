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
    
    var indexOfOneAndOnlyFaceUp: Int?
    
    // MARK: Methods
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUp, matchIndex != index {
                if cards[index].identifier == cards[matchIndex].identifier {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUp = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUp = index
            }
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
        print("number of cards = \(cards.count)")
        
        // TODO: Shuffle the cards.
    }
}
