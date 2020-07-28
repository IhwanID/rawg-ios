//
//  ViewController.swift
//  rawg
//
//  Created by Ihwan ID on 15/07/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var games = [Games]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
                    
                    //convert
                    
                    var result: GamesResponse?
                    do {
                        print(data.count)
                        result = try JSONDecoder().decode(GamesResponse.self, from: data)
                        
                    } catch{
                        print("error")
                    }
                    
                    guard let finalResult = result else{
                        return
                    }

            print(finalResult.results.count)

            self.games.append(contentsOf: finalResult.results)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
                    
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
         performSegue(withIdentifier: "toDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
    }
}
