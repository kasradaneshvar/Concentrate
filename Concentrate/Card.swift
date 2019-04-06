//
//  Card.swift
//  Concentrate
//
//  Created by Kasra Daneshvar on 4/6/19.
//  Copyright © 2019 Kasra Daneshvar. All rights reserved.
//

import Foundation

struct Card {
    var identifier: Int
    var isFaceUp = false
    var isMatched = false
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
    
}
