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
    
    var presenter: PhotoPresenter!
    
    var games = [Game]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "GamesTableViewCell", bundle: nil), forCellReuseIdentifier: "GameCell")
        presenter = PhotoPresenter()
        presenter.getAllGame(service: GamesService(), controller: self)
    }
    
    
    
}

extension ViewController: PhotoProtocol{
    func startLoading() {
        loading.startAnimating()
        loading.isHidden = false
        tableView.isHidden = true
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
            self.tableView.reloadData()
        }
        
    }
    
    func errorPhoto(error: Error) {
        print(error)
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
