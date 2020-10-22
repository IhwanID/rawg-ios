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

        if let result = game {
            if let id = result.id{
                presenter.getDetailGame(idGame: id, service: GamesService(), controller: self)
                if(objectExist(id: id)){
                    favoriteButton.image = UIImage(systemName: "heart.fill")
                }else{
                    favoriteButton.image = UIImage(systemName: "heart")
                }
            }

            setupLayout(id: result.id!, title: result.name!, released: result.released!, background_image: result.background_image, rating: result.rating!)
            
        }
    }

    func setupLayout(id:Int, title: String, released: String, background_image: String?, rating: Double){

        name.text = title
        gameTitle.text = "🗓\(released.toDate()?.toString() ?? "-") \n⭐️ \(rating)/5.0"
        presenter.getDetailGame(idGame: id, service: GamesService(), controller: self)
        if let background = background_image{
            let url = URL(string: background)
            self.photo.makeRounded()
            self.photo.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }else{
            self.photo.image = UIImage(named: "placeholder")
        }

    }
    @IBAction func onFavoriteClicked(_ sender: Any) {

        if let game = game{
            let container = try! Container()
            try! container.write { transaction in
                if let gameId = game.id{
                    if(!objectExist(id: gameId)){
                        transaction.add(game)
                        favoriteButton.image = UIImage(systemName: "heart.fill")
                    }else{
                        let objectsToDelete =  realm.object(ofType: GameObject.self, forPrimaryKey: gameId)!
                        realm.delete(objectsToDelete)
                        favoriteButton.image = UIImage(systemName: "heart")
                    }
                }

            }
        }

    }

}


extension DetailGamesViewController: DetailGameProtocol{
    func setGame(model: GameDetail) {
        DispatchQueue.main.async {
            self.descGame.attributedText = model.description?.htmlToAttributedString
        }
    }

    func errorGame(error: Error) {
        
    }

    func startLoading() {

    }

    func stopLoading() {
        DispatchQueue.main.async {

        }
    }

}

