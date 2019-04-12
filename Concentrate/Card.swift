//
//  Card.swift
//  Concentrate
//
//  Created by Kasra Daneshvar on 4/6/19.
//  Copyright © 2019 Kasra Daneshvar. All rights reserved.
//

import Foundation

struct Card: Hashable {
    // A somewhat ad-hoc implementation of `Hashable`.
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    private var identifier: Int
    var isFaceUp = false
    var isMatched = false
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
