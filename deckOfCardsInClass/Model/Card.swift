//
//  Deck.swift
//  deckOfCardsInClass
//
//  Created by Kamil Wrobel on 9/3/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import Foundation


//codable automaticly knows your decoding from json and automaticly decode its as a dictionary

struct DeckDictionary: Decodable {
    
    // this property is on a top lavel of the JSON
    //MARK:- Properties
    let cards : [Card]
    
    private enum CodingKeys: String, CodingKey {
        case cards = "cards"
    }
    
    struct Card: Decodable {
        let value : String
        let image : String
        let suit  : String
        
        
    }
    
    
}



