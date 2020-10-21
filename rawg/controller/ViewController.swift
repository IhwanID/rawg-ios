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
    lazy var rowsToDisplay = games
    


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

//    func searchBarSearchButtonClicked( _ searchBar: UISearchBar){
//        searchBar.resignFirstResponder()
//        presenter.searchGame(searchText: searchBar.text!,service: GamesService(), controller: self)
//
//    }

//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText.isEmpty {
//            DispatchQueue.main.async {
//                searchBar.resignFirstResponder()
//            }
//            presenter.getAllGame(service: GamesService(), controller: self)
//        }
//
//    }
    
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
    
    func setPhoto(model: [Game]) {
        DispatchQueue.main.async {
            self.games = model
            self.rowsToDisplay = self.games
            self.tableView.reloadData()
        }
    }
    
    func errorPhoto(error: Error) {
        print(error)
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {


        if rowsToDisplay.count == 0 {
            self.tableView.setEmptyMessage("No Game")
        } else {
            self.tableView.restore()
        }

        switch(segmentedControl.selectedSegmentIndex)
        {
        case 0:
            return rowsToDisplay.count
            
        case 1:
            return favoritesGame.count


        default:
            break
        }
        return rowsToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameTableViewCell

        switch(segmentedControl.selectedSegmentIndex)
        {
        case 0:
            cell.configure(with: games[indexPath.row])

            break
        case 1:
            cell.configure(with: favoritesGame[indexPath.row])
            return cell
            break

        default:
            break

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toDetail", sender: rowsToDisplay[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            guard let object = sender as? Game else { return }
            let vc = segue.destination as! DetailGamesViewController
            vc.game = object
            
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
