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
            self.photo.makeRounded()
            self.photo.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }else{
            self.photo.image = UIImage(named: "placeholder")
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let formate = dateFormatter.date(from: model.released ?? "01-01-2001")
        if let name = model.name {
            self.name.text = "\(name)"
        }

        self.rating.text = "🗓\(formate?.getFormattedDate(format: "dd MMM yyyy") ?? "-") \n⭐️ \(model.rating ?? 0)/5.0"

    }

    func configure(with model: GameObject){
        let url = URL(string: model.background_image)
        self.photo.makeRounded()
        self.photo.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let formate = dateFormatter.date(from: model.released)

        self.name.text = model.name


        self.rating.text = "🗓\(formate?.getFormattedDate(format: "dd MMM yyyy") ?? "-") \n⭐️ \(model.rating)/5.0"

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
