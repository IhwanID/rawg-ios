//
//  GamesTableViewCell.swift
//  rawg
//
//  Created by Ihwan ID on 28/07/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import UIKit
import Kingfisher
import SkeletonView

class GamesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var photo: UIImageView!
    
    @IBOutlet weak var rating: UILabel!
    
    @IBOutlet weak var shimmerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configure(with model: Game){
        self.shimmerView.startSkeletonAnimation()
        self.photo.kf.setImage(with: URL(string: model.background_image!)!)
        self.name.text = "\(model.name!)"
        self.rating.text = "\(model.released!) - ⭐️ \(model.rating!)/\(model.rating_top!)"
        
    }
}
