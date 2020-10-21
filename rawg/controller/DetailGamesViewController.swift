//
//  DetailGamesViewController.swift
//  rawg
//
//  Created by Ihwan ID on 28/07/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import UIKit
import RealmSwift

class DetailGamesViewController: UIViewController {
    
    @IBOutlet weak var photo: UIImageView!

    @IBOutlet weak var name: UILabel!
    var game: Game?
    
    var gameObject: GameObject?
    
    @IBOutlet weak var gameTitle: UILabel!

    @IBOutlet weak var descGame: UILabel!

    @IBOutlet weak var favoriteButton: UIBarButtonItem!

    var isFavorite = false

    var presenter: DetailGamePresenter!
    var realm: Realm!

    func objectExist (id: Int) -> Bool {
            return realm.object(ofType: GameObject.self, forPrimaryKey: id) != nil
    }


    override func viewDidLoad() {
        super.viewDidLoad()
         realm = try! Realm()
        presenter = DetailGamePresenter()

        self.photo.makeRounded()
        
        
        if let fav = gameObject{
            
                if(objectExist(id: fav.id)){
                    favoriteButton.image = UIImage(systemName: "heart.fill")
                }else{
                    favoriteButton.image = UIImage(systemName: "heart")
                }
            
            setupLayout(id: fav.id, title: fav.name, released: fav.released, background_image: fav.background_image, rating: fav.rating)
            
        }
        
        if let result = game {
            if let id = result.id{
                if(objectExist(id: id)){
                    favoriteButton.image = UIImage(systemName: "heart.fill")
                }else{
                    favoriteButton.image = UIImage(systemName: "heart")
                }
            }
        
            setupLayout(id: result.id!, title: result.name!, released: result.released!, background_image: result.background_image!, rating: result.rating!)
            
        }
    }

    func setupLayout(id:Int, title: String, released: String, background_image: String, rating: Double){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        gameTitle.text = title
        let formate = dateFormatter.date(from: released)
        name.text = "🗓\(formate?.getFormattedDate(format: "dd MMM yyyy") ?? "-") \n⭐️ \(rating)/5.0"
        presenter.getDetailGame(idGame: id, service: GamesService(), controller: self)
        if(background_image != nil){
            let url = URL(string: background_image)
            self.photo.makeRounded()
            self.photo.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }else{
            self.photo.image = UIImage(named: "placeholder")
        }
    }
    @IBAction func onFavoriteClicked(_ sender: Any) {

        if let game = game {
            let container = try! Container()
            try! container.write { transaction in
                if(!objectExist(id: game.id!)){
                    transaction.add(game)
                    favoriteButton.image = UIImage(systemName: "heart.fill")
                }else{
                    let objectsToDelete =  realm.objects(GameObject.self).filter("NOT id IN %@", game.id!)
                    realm.delete(objectsToDelete)
                    favoriteButton.image = UIImage(systemName: "heart")
                }
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
           // self.descGame.attributedText = model.description.htmlToAttributedString 
        }

    }

    func errorGame(error: Error) {
        print(error)
    }

    func startLoading() {

    }

    func stopLoading() {
        DispatchQueue.main.async {

        }
    }

}

