//
//  DetailGamePresenter.swift
//  rawg
//
//  Created by Ihwan ID on 30/09/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import Foundation

class DetailGamePresenter{

    func getDetailGame(idGame: Int, service: GamesService, controller: DetailGameProtocol){
        print(idGame)
        controller.startLoading()
        service.fetchDetailGame(id: idGame){ (game, error) in
            controller.stopLoading()
            if(error != nil){
                controller.errorGame(error: error!)
            }else{
                controller.setGame(model: game)
            }
        }
    }
    
}

protocol DetailGameProtocol {
    func startLoading()
    func stopLoading()
    func setGame(model: Game)
    func errorGame(error: Error)
}
