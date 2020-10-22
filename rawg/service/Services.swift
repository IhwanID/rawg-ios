//
//  Services.swift
//  rawg
//
//  Created by Ihwan ID on 21/08/20.
//  Copyright © 2020 Ihwan ID. All rights reserved.
//

import Foundation

class GamesService{

    func searchGames(searchtext: String?,completion: @escaping ([Game], Error?) -> Void){

        guard let text = searchtext, !text.isEmpty else {
            return
        }

        let query = text.replacingOccurrences(of: " ", with: "%20")

        URLSession.shared.dataTask(with: URL(string: "https://api.rawg.io/api/games?search=\(query)")!, completionHandler: {data, response, error in

            guard let data = data, error == nil else{
                return
            }

            var result: GameResponse?
            do {
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


    func loadGames(completion: @escaping ([Game], Error?) -> Void){
        URLSession.shared.dataTask(with: URL(string: "https://api.rawg.io/api/games")!, completionHandler: {data, response, error in
            guard let data = data, error == nil else{
                return
            }

            var result: GameResponse?
            do {
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

    func fetchDetailGame(id: Int,completion: @escaping (GameDetail, Error?) -> Void ){
        URLSession.shared.dataTask(with: URL(string: "https://api.rawg.io/api/games/\(id)")!, completionHandler: {data, response, error in
            guard let data = data, error == nil else{
                return
            }

            var result: GameDetail?
            do {
                result = try JSONDecoder().decode(GameDetail.self, from: data)

            } catch{
                print("error")
            }

            guard let finalResult = result else{
                return
            }

            completion(finalResult, error)


        }).resume()
    }
}
