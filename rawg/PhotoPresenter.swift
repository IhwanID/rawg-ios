//
//  PhotoPresenter.swift
//  rawg
//
//  Created by Ihwan ID on 21/08/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import Foundation

class PhotoPresenter{
    func getAllGame(service: GamesService, controller: PhotoProtocol){
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
    
    
}


protocol PhotoProtocol {
    func startLoading()
    func stopLoading()
    func setPhoto(model: [Game])
    func errorPhoto(error: Error)
}
