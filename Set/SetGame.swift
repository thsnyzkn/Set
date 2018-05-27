//
//  SetGame.swift
//  Set
//
//  Created by Tahsin Yazkan on 2.05.2018.
//  Copyright © 2018 Tahsin Yazkan. All rights reserved.
//

import Foundation


struct SetGame
{
    private(set) var allCards = [SetCard]()
    private(set) var cardsOnTable = [SetCard]()
    private(set) var selectedCards = [SetCard]()
    private(set) var matchedCards = [SetCard]()
    private(set) var score = 0
    
    
    
    init() {
        newGame()
    }
    mutating func produceAllCards() {
        for number in SetCard.Numbers.all{
            for symbol in SetCard.Symbols.all{
                for shading in SetCard.Shadings.all{
                    for color in SetCard.Colors.all{
                        allCards.append(SetCard(number: number, symbol: symbol, shading: shading, color: color))
                    }
                }
            }
        }
    }
    mutating func drawThreeCards(){
        drawCards(numberOfCardsToSelect: 3)
    }
    mutating func newGame(){
        allCards.removeAll()
        cardsOnTable.removeAll()
        selectedCards.removeAll()
        matchedCards.removeAll()
        produceAllCards()
        drawCards(numberOfCardsToSelect: 24)
        
    }
    mutating func drawCard()->SetCard?{
        if allCards.count > 0{
            return allCards.remove(at: allCards.count.arc4random)
        }else{
            return nil
        }
        
    }
    mutating func drawCards(numberOfCardsToSelect cards:Int) {
        for _ in 1...cards{
            cardsOnTable.append(drawCard()!)
        }
        
    }
    @discardableResult
    mutating func isSet()->Bool{
        if selectedCards.count != 3{
            return false
        }
        if selectedCards[0].color == selectedCards[1].color{
            if selectedCards[0].color != selectedCards[2].color || selectedCards[1].color != selectedCards[2].color {
                return false
            }
        }
        else if selectedCards[1].color == selectedCards[2].color{return false}
        else if selectedCards[0].color == selectedCards[2].color{return false}
        
        if selectedCards[0].symbol == selectedCards[1].symbol{
            if selectedCards[0].symbol != selectedCards[2].symbol || selectedCards[1].symbol != selectedCards[2].symbol {
                return false
            }
        }
        else if selectedCards[1].symbol == selectedCards[2].symbol{return false}
        else if selectedCards[0].symbol == selectedCards[2].symbol{return false}
        if selectedCards[0].number == selectedCards[1].number{
            if selectedCards[0].number != selectedCards[2].number || selectedCards[1].number != selectedCards[2].number {
                return false
            }
        }
        else if selectedCards[1].number == selectedCards[2].number{return false}
        else if selectedCards[0].number == selectedCards[2].number{return false}
        if selectedCards[0].shading == selectedCards[1].shading{
            if selectedCards[0].shading != selectedCards[2].shading || selectedCards[1].shading != selectedCards[2].shading {
                return false
            }
        }
        else if selectedCards[1].shading == selectedCards[2].shading{return false}
        else if selectedCards[0].shading == selectedCards[2].shading{return false}
        return true
    }
    mutating func chooseCard(at index: Int){
        assert(cardsOnTable.indices.contains(index), "Game.chooseCard(at : \(index) chosen index not on the table")
        print("\(index)")
        if selectedCards.count == 3{
            
            if isSet(){
               
                print("isInSet")
                for cardIndex in selectedCards.indices{
                    selectedCards[cardIndex].isInSet = true
                    matchedCards.append(selectedCards[cardIndex])
                    if let indexToBeChanged = cardsOnTable.index(of: selectedCards[cardIndex]){
                        cardsOnTable.remove(at: indexToBeChanged)
                        print ("Index to be Changed:\(indexToBeChanged)")
                        let removed = allCards.remove(at: allCards.count.arc4random)
                        cardsOnTable.insert(removed, at: indexToBeChanged)
                        cardsOnTable[indexToBeChanged].isChosen = false
                    }
                }
                score+=3
            }
            else {
                print("not in set")
                for cardIndex in selectedCards.indices{
                    if let indexOfSelected = cardsOnTable.index(of: selectedCards[cardIndex]){
                        cardsOnTable[indexOfSelected].isChosen = false
                    }
                }
                score-=1
            }
            selectedCards.removeAll()
            selectedCards.append(cardsOnTable[index])
            cardsOnTable[index].isChosen = true
        }
       else if selectedCards.count < 3 {
       
           // print("card will be added")
            if cardsOnTable[index].isChosen{
                
                 print ("\(cardsOnTable[index])", "\(cardsOnTable[index].isChosen)")
                print("button already chosen")
                if let indexOfChosen = selectedCards.index(of: cardsOnTable[index]){
                    selectedCards.remove(at: indexOfChosen)
                }
                cardsOnTable[index].isChosen = false
            }
            else{
               
                 print ("\(cardsOnTable[index])", "\(cardsOnTable[index].isChosen)")
                print("button is touched/chosen")
         
                selectedCards.append(cardsOnTable[index])
                 cardsOnTable[index].isChosen = true
            }
       
          
        }
        
    }
}

extension Int {
    var arc4random: Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else {
            return 0
        }
        
    }
}




