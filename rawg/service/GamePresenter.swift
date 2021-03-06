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
                controller.errorGame(error: error!)
            }else{
                controller.setGame(model: game)
            }
        }
    }

    
}


protocol GameProtocol {
    func startLoading()
    func stopLoading()
    func setGame(model: [Game])
    func errorGame(error: Error)
}
