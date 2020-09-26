//
//  GameTableViewCell.swift
//  rawg
//
//  Created by Ihwan ID on 25/09/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!

    @IBOutlet weak var photo: UIImageView!

    @IBOutlet weak var rating: UILabel!


    func configure(with model: Game){
        if(model.background_image != nil){
            let url = URL(string: model.background_image!)
            self.photo.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }else{
            self.photo.image = UIImage(named: "placeholder")
        }

        self.name.text = "\(model.name!)"
        self.rating.text = "🗓\(model.released ?? "-")\n⭐️ \(model.rating ?? 0)/\(model.rating_top ?? 0)"

    }
}
