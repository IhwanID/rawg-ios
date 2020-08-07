//
//  DetailGamesViewController.swift
//  rawg
//
//  Created by Ihwan ID on 28/07/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import UIKit

class DetailGamesViewController: UIViewController {

    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    var game: Game?
    
    @IBOutlet weak var gameTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let result = game {
            
           
            
            gameTitle.text = result.name
                       name.text = "\(result.released!) - ⭐️ \(result.rating!)/\(result.rating_top!)"
                   
       
                       DispatchQueue.main.async{
                                 if let data = try? Data(contentsOf: URL(string:  result.background_image!)!){
                                            self.photo.image = UIImage(data: data)
                             }
                             }
       
           
        }
        
    }

    
    
}

