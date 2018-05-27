//
//  ButtonSpecifications.swift
//  Set
//
//  Created by Tahsin Yazkan on 2.05.2018.
//  Copyright © 2018 Tahsin Yazkan. All rights reserved.
//

import Foundation
import UIKit

struct ButtonSpecifications
    
{
    mutating func getColor (of card:SetCard)->UIColor{
        
        switch card.color{
        case .green: return #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        case .purple: return #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        case .red: return #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
    }
    mutating func getSymbol (of card:SetCard)-> String{
        switch card.symbol {
        case .oval:return "●"
        case .squiggle: return "■"
        case .triangle: return "▲"
        }
    }
    mutating func getNumbers(of card: SetCard, with symbol: String) ->String{
        switch card.number {
        case .one: return "\(symbol)"
        case .two: return "\(symbol)\(symbol)"
        case .three: return "\(symbol)\(symbol)\(symbol)"
        }
    }
    mutating func getShading(of card: SetCard,color buttonColor:UIColor,with title:String)->NSAttributedString{
        var attributes = [NSAttributedStringKey:Any]()
        
        switch card.shading {
        case .empty:
            attributes = [
                .strokeWidth : 5.0,
                .foregroundColor : buttonColor
            ]
        case .filled:
            attributes = [
                .strokeWidth: -5.0,
                .foregroundColor : buttonColor
                
            ]
        case .striped: attributes = [
            .strokeWidth: -5.0,
            .foregroundColor : buttonColor.withAlphaComponent(0.15)
            
            ]
        }
        let attributed = NSAttributedString(string: "\(title)", attributes: attributes)
        return attributed
    }
    mutating func createButton(for card:SetCard, on aButton:UIButton){
        let color = getColor(of: card)
        let symbol = getSymbol(of: card)
        let number = getNumbers(of: card, with: symbol)
        let shading = getShading(of: card, color: color, with: number)
        
        
        aButton.setAttributedTitle(shading, for: .normal)
        aButton.layer.borderWidth = 1.0
        aButton.layer.borderColor = #colorLiteral(red: 0.09431670984, green: 0.02631369862, blue: 0.02411657788, alpha: 1)
    }
    mutating func clearButton(for card:SetCard, on aButton:UIButton){
        aButton.setAttributedTitle(nil, for: .normal)
        aButton.layer.borderWidth = 1.0
        aButton.layer.borderColor = #colorLiteral(red: 0.09431670984, green: 0.02631369862, blue: 0.02411657788, alpha: 1)
    }
}

