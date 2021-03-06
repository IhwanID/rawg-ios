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


extension Date {
   func getFormattedDate(format: String) -> String {

        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}

extension UIImageView {

    func makeRounded() {
        self.layer.borderWidth = 0
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }
}
