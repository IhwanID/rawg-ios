//
//  PhotoPresenter.swift
//  rawg
//
//  Created by Ihwan ID on 21/08/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import Foundation

class GamePresenter{
    func getAllGame(service: GamesService, controller: GameProtocol){
        controller.startLoading()
        service.loadGames { (game, error) in
            controller.stopLoading()
            if(error != nil){
                controller.errorPhoto(error: error as! Error)
            }else{
                controller.setPhoto(model: game)
            }
        }
    }

    func searchGame(searchText: String, service: GamesService, controller: GameProtocol){
        controller.startLoading()
        service.searchGames(searchtext: searchText) { (game, error) in
         controller.stopLoading()
            if(error != nil){
               // controller.errorPhoto(error: error as! Error)
            }else{
               controller.setPhoto(model: game)
            }
        }
    }
    
}


protocol GameProtocol {
    func startLoading()
    func stopLoading()
    func setPhoto(model: [Game])
    func errorPhoto(error: Error)
}
