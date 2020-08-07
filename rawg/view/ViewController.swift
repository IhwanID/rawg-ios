//
//  ViewController.swift
//  rawg
//
//  Created by Ihwan ID on 15/07/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var games = [Game]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loading.startAnimating()
        loading.isHidden = false
        tableView.isHidden = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "GamesTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCell")
        loadGames()
    }

    func loadGames(){
        URLSession.shared.dataTask(with: URL(string: "https://api.rawg.io/api/games")!, completionHandler: {data, response, error in
                    
                    guard let data = data, error == nil else{
                        return
                    }
                    var result: GameResponse?
                    do {
                        print(data.count)
                        result = try JSONDecoder().decode(GameResponse.self, from: data)
                        
                    } catch{
                        print("error")
                    }
                    
                    guard let finalResult = result else{
                        return
                    }

            self.games.append(contentsOf: finalResult.results)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            self.loading.stopAnimating()
            
            self.tableView.isHidden = false
            self.loading.isHidden = true
                    
        }).resume()
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GamesTableViewCell
        cell.configure(with: games[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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

