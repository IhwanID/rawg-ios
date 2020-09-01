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
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var name: UILabel!
    var game: Game?
    
    @IBOutlet weak var gameTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.indicator.isHidden = false
        self.indicator.startAnimating()
        self.photo.isHidden = true
        if let result = game {
            
            gameTitle.text = result.name
            name.text = "\(result.released!) - ⭐️ \(result.rating!)/\(result.rating_top!)"
            
            DispatchQueue.global().async{
                if let data = try? Data(contentsOf: URL(string: result.background_image!)!){
                    DispatchQueue.main.async {
                        self.photo.image = UIImage(data: data)
                        self.photo.isHidden = false
                        self.indicator.isHidden = true
                        self.indicator.stopAnimating()
                    }
                    
                }
            }
            
            
        }
        
    }
    
    
    
}

