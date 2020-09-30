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

    @IBOutlet weak var descGame: UILabel!

    var presenter: DetailGamePresenter!

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = DetailGamePresenter()

        self.photo.makeRounded()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"


        if let result = game {
            gameTitle.text = result.name
            let formate = dateFormatter.date(from: result.released ?? "01-01-2001")
            name.text = "🗓\(formate?.getFormattedDate(format: "dd MMM yyyy") ?? "-") \n⭐️ \(result.rating ?? 0)/\(result.rating_top ?? 0)"
            presenter.getDetailGame(idGame: result.id!, service: GamesService(), controller: self)
            if(result.background_image != nil){
                let url = URL(string: result.background_image!)
                self.photo.makeRounded()
                self.photo.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
            }else{
                self.photo.image = UIImage(named: "placeholder")
            }
        }
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

extension DetailGamesViewController: DetailGameProtocol{
    func setGame(model: Game) {
        DispatchQueue.main.async {
            self.descGame.attributedText = model.description?.htmlToAttributedString
        }

    }

    func errorGame(error: Error) {
        print(error)
    }

    func startLoading() {

        print("started")
    }

    func stopLoading() {
        DispatchQueue.main.async {

        }
    }

}

