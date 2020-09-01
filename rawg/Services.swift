//
//  Services.swift
//  rawg
//
//  Created by Ihwan ID on 21/08/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import Foundation

class GamesService{
    
    func loadGames(completion: @escaping ([Game], Error?) -> ()){
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
            
            completion(finalResult.results, error)
            
            
        }).resume()
        
    }
}
