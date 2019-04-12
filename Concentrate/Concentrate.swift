//
//  Concentrate.swift
//  Concentrate
//
//  Created by Kasra Daneshvar on 4/6/19.
//  Copyright © 2019 Kasra Daneshvar. All rights reserved.
//

import Foundation

struct Concentrate {
    
    // MARK: Properties
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUp: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly // Extension: Collection.
//
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    // MARK: Methods
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentrate.chooseCrad(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUp, matchIndex != index {
                if cards[index] == cards[matchIndex] {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUp = index
            }
        }
    }
    
    // MARK: Initializer.
    // This only takes the number of pairs of cards and it has to initialize `cards` with that many cards of unique identifiers.
    // ❓: Is it possible to just pass the `nubmerOfPairs...` to the Array initializer and have it take care of initializing the cards?
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Consentrate.init(\(numberOfPairsOfCards): you must have at least one pair of cards")
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        // TODO: Shuffle the cards.
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
