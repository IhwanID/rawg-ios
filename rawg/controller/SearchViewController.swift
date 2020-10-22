//
//  SearchViewController.swift
//  rawg
//
//  Created by Ihwan ID on 22/10/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController , UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!

    var presenter: SearchGamePresenter!
    var games = [Game]()
    var loading = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter = SearchGamePresenter()

        searchBar.delegate = self
    }

    func activityIndicator(){
        loading = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        loading.style = UIActivityIndicatorView.Style.large
        loading.center = self.view.center
        self.view.addSubview(loading)
    }
    

    func searchBarSearchButtonClicked( _ searchBar: UISearchBar){
        searchBar.resignFirstResponder()
        print(searchBar.text!)
        presenter.searchGame(searchText: searchBar.text!,service: GamesService(), controller: self)

    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameSearchCell", for: indexPath) as! GameSearchTableViewCell

        cell.configure(with: games[indexPath.row])

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toDetail", sender: games[indexPath.row])

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {

            guard let object = sender as? Game else { return }
            let vc = segue.destination as! DetailGamesViewController
            vc.game = object
        }
    }

}

extension SearchViewController: SearchGameProtocol{
    func errorGame(error: Error) {
        print(error)
    }

    func startLoading() {
        loading.startAnimating()
        loading.isHidden = false
        self.games.removeAll()
    }

    func stopLoading() {
        DispatchQueue.main.async {
            self.loading.stopAnimating()
            self.loading.isHidden = true
        }
    }

    func setGame(model: [Game]) {
        DispatchQueue.main.async {
            self.games = model
            self.tableView.reloadData()
        }
    }

}
