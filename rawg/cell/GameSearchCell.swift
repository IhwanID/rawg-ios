//
//  GameSearchCell.swift
//  rawg
//
//  Created by Ihwan ID on 22/10/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class GameSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: UILabel!
    

    func configure(with model: Game){
        if let background = model.background_image{
            let url = URL(string: background)
            self.photo.makeRounded()
            self.photo.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }else{
            self.photo.image = UIImage(named: "placeholder")
        }

        if let name = model.name {
            self.name.text = "\(name)"
        }

        self.rating.text = "🗓\(model.released?.toDate()?.toString() ?? "-") \n⭐️ \(model.rating ?? 0)/5.0"

    }
}


