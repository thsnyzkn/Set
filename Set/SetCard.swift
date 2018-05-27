//
//  SetCard.swift
//  Set
//
//  Created by Tahsin Yazkan on 2.05.2018.
//  Copyright © 2018 Tahsin Yazkan. All rights reserved.
//

import Foundation

struct SetCard:Equatable, CustomStringConvertible
{
    var description: String {
        return " \(number) \(symbol) \(shading) \(color) "
    }
    
    static func == (lhs: SetCard, rhs: SetCard) -> Bool {
        return lhs.color == rhs.color && lhs.number == rhs.number && lhs.shading == rhs.shading && lhs.symbol == rhs.symbol
    }
    
    let number: Numbers
    let symbol: Symbols
    let shading: Shadings
    let color: Colors
    
    var isChosen = false
    var isInSet = false
    
   
    
    
    enum Numbers {
        case one
        case two
        case three
        
        static var all = [Numbers.one, .two, .three]
        
    }
    enum Symbols{
        case squiggle
        case triangle
        case oval
        
        static var all = [Symbols.squiggle, .triangle, .oval]
    }
    enum Shadings {
        case empty
        case striped
        case filled
        
        static var all = [Shadings.empty, .striped, .filled]
        
    }
    enum Colors {
        case red
        case green
        case purple
        
        static var all = [Colors.red, .green, .purple]
    }
    init(number:Numbers, symbol:Symbols, shading:Shadings, color:Colors){
        self.number = number
        self.symbol = symbol
        self.shading = shading
        self.color = color
        
    }
    
}

