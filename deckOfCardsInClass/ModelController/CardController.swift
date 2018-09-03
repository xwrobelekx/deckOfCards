//
//  CardController.swift
//  deckOfCardsInClass
//
//  Created by Kamil Wrobel on 9/3/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit


// How to build your URL
// 1) Components are /
// 2) Query items are [:]
// 3) Extensions are .


class CardController {
    static let shared = CardController()
    
    //creates true singelton. That way you can only have ONE instance of this class
    private init() {}
    
    //https://deckofcardsapi.com/api/deck/<<deck_id>>/draw/?count=1
    private let baseURLString = "https://deckofcardsapi.com/api/deck/"
    
    
    func fetchCard(count: Int,  completion: @escaping ([Card]?) -> Void) {
        
        guard let baseURL = URL(string: baseURLString) else {
            //break our code and dont continue. Error message to developer
            fatalError("Bad base url")
            
        }
        
        // this is how you add a componnent to your url ("/")
        let newURL = baseURL.appendingPathComponent("new").appendingPathComponent("draw")
        
        // Build your URL
        //A structure that parses URLs into and constructs URLs from their constituent parts.
        var components = URLComponents(url: newURL, resolvingAgainstBaseURL: true)
        // this is the dictionary of the user search term, when they hit the draw button
        let querryItems = URLQueryItem(name: "count", value: "\(count)")
        
        //
        components?.queryItems = [querryItems]
        
        print("Querry Items: Is it on main tread: 🍑\(Thread.isMainThread) ")
        
        // this is the final Request url
        guard let url = components?.url else {
            completion([])
            return
            
        }
        
        //dataTask with URL has the http protocol build within it
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //1) handle error
            print("URL Session: Is it on main tread: 🍑\(Thread.isMainThread) ")
            if let error = error {
                //THIS IS JUST FOR DEVELOPER - not user
                print("There was an error fetchin data from dataTask: \(#function) \(error) \(error.localizedDescription)")
                completion([])
                return
            }
            //response - not needed in this app
            if let responseCode = response {
                // it prints the response code form website like 404, 200 ...
               // print(responseCode)
            }
            
            
            //2) handle data
            guard let dataThatCameBack = data else {
                print("No Data returned")
                completion([])
                return
            }
            
            //)3 use JSONDecoder to decode your object
            do {
                let cards = try JSONDecoder().decode(DeckDictionary.self, from: dataThatCameBack).cards
                
                // call the completion handler
                completion(cards)
                
                
            } catch let error{
                print("There was an error decoding our objct \(error) \(error.localizedDescription)")
                completion([])
                return
            }
            
            }.resume()
        
    }
    
    
    
    
    //getting the image
    
    func fetchCardImage(card: Card, completion: @escaping (UIImage?) -> Void){
        guard let url = URL(string: card.image) else {
            print("Invalis image url")
            return
            
        }
         print("before URL sesioon for picture : Is it on main tread: 🍑\(Thread.isMainThread) ")
        URLSession.shared.dataTask(with: url) { (data, _, error) in
             print("URL Session of image : Is it on main tread: 🍑\(Thread.isMainThread) ")
            if let error = error {
                print("Error with fetching image data task \(error) \(error.localizedDescription)")
                //complete with nothing, and return out of this function
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                print("no imge data")
                return
            }
            guard let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            completion(image)
        }.resume()
    }
}













