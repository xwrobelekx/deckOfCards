//
//  CardViewController.swift
//  deckOfCardsInClass
//
//  Created by Kamil Wrobel on 9/3/18.
//  Copyright © 2018 Kamil Wrobel. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var suitLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
       // view.addVerticalGradientLayer(topColor: .blue, bottomColor: .purple)
        view.addVerticalGradientLayer(topColor: #colorLiteral(red: 0.06423400962, green: 0.3964772886, blue: 0.9686274529, alpha: 1), bottomColor: #colorLiteral(red: 0.6214522433, green: 0.07530048562, blue: 0.8082170051, alpha: 1))
    }



    @IBAction func drawButtonTapped(_ sender: Any) {
        updateViews()
    }
    
    
    func updateViews() {
        
        CardController.shared.fetchCard(count: 1) { (cards) in
            
            // we want first card that came back
                guard let card = cards?.first else {return}
            
            DispatchQueue.main.async {
                self.suitLabel.text = card.suit
                self.valueLabel.text = card.value
                
                print("updating Labels: Is it on main tread: 🍑\(Thread.isMainThread) ")
            }
            CardController.shared.fetchCardImage(card: card, completion: { (image) in
                DispatchQueue.main.async {
                    self.cardImageView.image = image
                }
            })
        }
    }
}
