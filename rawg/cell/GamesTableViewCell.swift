//
//  GamesTableViewCell.swift
//  rawg
//
//  Created by Ihwan ID on 28/07/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import UIKit

class GamesTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var photo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: Game){
        self.name.text = "\(model.name!) \n\(model.released!) - ⭐️ \(model.rating!)/\(model.rating_top!)"
        
    
        DispatchQueue.main.async{
            if let data = try? Data(contentsOf: URL(string:  model.background_image!)!){
                       self.photo.image = UIImage(data: data)
        }
        }
       
        
    }
}
