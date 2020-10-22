//
//  SearchPresenter.swift
//  rawg
//
//  Created by Ihwan ID on 22/10/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import Foundation

class SearchGamePresenter{
    func searchGame(searchText: String, service: GamesService, controller: SearchGameProtocol){
        controller.startLoading()
        service.searchGames(searchtext: searchText) { (game, error) in

            controller.stopLoading()
            if(error != nil){
                // controller.errorPhoto(error: error as! Error)
            }else{
                controller.setGame(model: game)
            }
        }
    }
}

protocol SearchGameProtocol {
    func startLoading()
    func stopLoading()
    func setGame(model: [Game])
    func errorGame(error: Error)
}
