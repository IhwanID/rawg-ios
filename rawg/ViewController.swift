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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
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

                    
        }).resume()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //
    }
}
