//
//  SearchGameViewController.swift
//  rawg
//
//  Created by Ihwan ID on 08/08/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import UIKit

class SearchGameViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    var games = [Game]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "GamesTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCell")
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.showsScopeBar = true
        searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked( _ searchBar: UISearchBar)
    {
        searchGame()
    }
    
    
    func searchGame(){
        searchBar.resignFirstResponder()
        
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        let query = text.replacingOccurrences(of: " ", with: "%20")
        games.removeAll()
        
        URLSession.shared.dataTask(with: URL(string: "https://api.rawg.io/api/games?search=\(query)")!, completionHandler: {data, response, error in
            
            guard let data = data, error == nil else{
                return
            }
            
            //convert
            
            var result: GameResponse?
            do {
                result = try JSONDecoder().decode(GameResponse.self, from: data)
            } catch{
                print("error")
            }
            
            guard let finalResult = result else{
                return
            }
            
            //update movie array
            let newMovies = finalResult.results
            self.games.append(contentsOf: newMovies)
            
            //refresh table
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }).resume()
        
        
    }    //table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        cell.textLabel?.text = games[indexPath.row].name
        return cell
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GamesTableViewCell
        //        cell.configure(with: games[indexPath.row])
        //        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //show detail
        
    }
    
}
