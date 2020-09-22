//
//  GamesTableViewCell.swift
//  rawg
//
//  Created by Ihwan ID on 28/07/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import UIKit
import Kingfisher

class GamesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var rating: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(with model: Game){
        if(model.background_image != nil){
            let url = URL(string: model.background_image!)
                   let processor = DownsamplingImageProcessor(size: photo.bounds.size)
                    |> RoundCornerImageProcessor(cornerRadius: 20)
                  self.photo.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"),
                      options: [
                          .processor(processor),
                          .scaleFactor(UIScreen.main.scale),
                          .transition(.fade(1)),
                          .cacheOriginalImage
                      ])
        }else{
self.photo.image = UIImage(named: "placeholder")
        }

        self.name.text = "\(model.name!)"
        self.rating.text = "🗓\(model.released ?? "-")\n⭐️ \(model.rating ?? 0)/\(model.rating_top ?? 0)"
        
    }
}
