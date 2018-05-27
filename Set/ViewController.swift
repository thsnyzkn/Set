//
//  ViewController.swift
//  Set
//
//  Created by Tahsin Yazkan on 30.04.2018.
//  Copyright © 2018 Tahsin Yazkan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var game = SetGame()
    var a = ButtonSpecifications()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        gameCreation()
        
        
    }
    
    @IBOutlet weak var threeCardsButton: UIButton!
    @IBAction func dealThreeCards(_ sender: UIButton) {
        print(cardButtons.places)
        
        if cardButtons.visibleButtons.count<24{
            for _ in 0...2{
                let randomIndex = cardButtons.places.count.arc4random
                let randomPlace = cardButtons.places[randomIndex]
                let card = game.cardsOnTable[randomPlace]
                let button = cardButtons[randomPlace]
                a.createButton(for: card, on: button)
                cardButtons[randomPlace].isHidden = false
            }
        }else{
            threeCardsButton.isEnabled = false
        }
    }
    
    @IBAction func createGame(_ sender: UIButton) {
        threeCardsButton.isEnabled = true
        gameCreation()
    }
    func gameCreation(){
        game = SetGame()
        makeAllCardsOnSceneInvisible()
        var count = 0
        for _ in cardButtons.indices{
            let randomIndex = 24.arc4random
            if count<12, cardButtons[randomIndex].isHidden{
                cardButtons[randomIndex].isHidden = false
                a.createButton(for: game.cardsOnTable[randomIndex], on: cardButtons[randomIndex])
                count+=1
                
            }
        }
    }
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func cardSelected(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            for index in game.matchedCards.indices{
                print (game.matchedCards[index])
            }
            game.chooseCard(at: cardNumber)
            for index in cardButtons.indices{
                let button = cardButtons[index]
                let card = game.cardsOnTable[index]
                if game.selectedCards.contains(card){
                    button.layer.borderColor = #colorLiteral(red: 1, green: 0.3272506719, blue: 0.1631540863, alpha: 1)
                    button.layer.borderWidth = 3.0
                }else if game.selectedCards.contains(where: {$0.isInSet}){
                    button.layer.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                    button.layer.borderWidth = 4.0
                    a.createButton(for: card, on: button)
                    threeCardsButton.titleLabel?.text = "ssssssssss"
                    
                }else{
                    button.layer.borderColor = #colorLiteral(red: 0.09431670984, green: 0.02631369862, blue: 0.02411657788, alpha: 1)
                    button.layer.borderWidth = 1.0
                }
                
            }
        }
    }
    
    
    func makeAllCardsOnSceneInvisible(){
        for index in cardButtons.indices{
            a.clearButton(for: game.allCards[index], on: cardButtons[index])
            cardButtons[index].isHidden = true
        }
    }
    
}
extension Array where Element:UIButton{
    var visibleButtons:[Element?]{
        
        return filter{!$0.isHidden}
    }
    var hiddenButtons:[Element?]{
        
        return filter{$0.isHidden}
    }
    var places:[Index]{
        get{
            var indices = [Index]()
            for index in startIndex..<endIndex where self[index].isHidden{
                indices.append(index)
            }
            return indices
        }
    }
    func placesOfHidden() -> [Index]{
        var indices = [Index]()
        for index in startIndex..<endIndex where self[index].isHidden{
            indices.append(index)
        }
        return indices
    }
}


