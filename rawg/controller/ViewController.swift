//
//  ViewController.swift
//  rawg
//
//  Created by Ihwan ID on 15/07/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var loading = UIActivityIndicatorView()
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: GamePresenter!
    var games = [Game]()
    var favoritesGame = [GameObject]()
    var realm: Realm!

    override func viewWillAppear(_ animated: Bool) {
        favoritesGame = Array(realm.objects(GameObject.self))
        tableView.reloadData()
    }
    func activityIndicator(){
        loading = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        loading.style = UIActivityIndicatorView.Style.large
        loading.center = self.view.center
        self.view.addSubview(loading)
    }

    @IBAction func onSegmentedValueChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 1:
            favoritesGame = Array(realm.objects(GameObject.self))
            break
        default:
            break
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
        favoritesGame = Array(realm.objects(GameObject.self))
        activityIndicator()
        tableView.delegate = self
        tableView.dataSource = self

        presenter = GamePresenter()
        presenter.getAllGame(service: GamesService(), controller: self)
    }
}

extension ViewController: GameProtocol{
    func startLoading() {
        loading.startAnimating()
        loading.isHidden = false
        tableView.isHidden = true
        self.games.removeAll()
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.loading.stopAnimating()
            self.tableView.isHidden = false
            self.loading.isHidden = true
        }
    }
    
    func setGame(model: [Game]) {
        DispatchQueue.main.async {
            self.games = model
            self.tableView.reloadData()
        }
    }
    
    func errorGame(error: Error) {
        print(error)
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch(segmentedControl.selectedSegmentIndex)
        {
        case 0:
            if games.count == 0 {
                self.tableView.setEmptyMessage("No Game")
            } else {
                self.tableView.restore()
            }
            return games.count
            
        case 1:
            if favoritesGame.count == 0 {
                self.tableView.setEmptyMessage("No Favorite Game")
            } else {
                self.tableView.restore()
            }
            return favoritesGame.count


        default:
            break
        }
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameTableViewCell

        switch(segmentedControl.selectedSegmentIndex)
        {
        case 0:
            cell.configure(with: games[indexPath.row])
            return cell
        case 1:
            cell.configure(with: Game(id: favoritesGame[indexPath.row].id, name: favoritesGame[indexPath.row].name, background_image: favoritesGame[indexPath.row].background_image, released: favoritesGame[indexPath.row].released, rating: favoritesGame[indexPath.row].rating))
            return cell

        default:
            break

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch(segmentedControl.selectedSegmentIndex)
        {
        case 0:
            performSegue(withIdentifier: "toDetail", sender: games[indexPath.row])
            break
        case 1:
            performSegue(withIdentifier: "toDetail", sender: favoritesGame[indexPath.row])
            break

        default:
            break

        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if(sender is Game){
                guard let object = sender as? Game else { return }
                let vc = segue.destination as! DetailGamesViewController
                vc.game = object
            }else{
                guard let object = sender as? GameObject else { return }
                let vc = segue.destination as! DetailGamesViewController
                vc.game = Game(id: object.id, name: object.name, background_image: object.background_image, released: object.released, rating: object.rating)
            }
           
            
        }
    }

}

extension UITableView{
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
