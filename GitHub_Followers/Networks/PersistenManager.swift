//
//  PersistenManager.swift
//  GitHub_Followers
//
//  Created by Maxim Granchenko on 11.05.2020.
//  Copyright © 2020 Maxim Granchenko. All rights reserved.
//

import Foundation

enum PersistenActionType {
    case add, remove
}

enum PersistenManager {
    
    static let userDefault = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Follower, actionType: PersistenActionType, completed: @escaping (GFError?) -> Void) {
        retrieveFolower { result in
            switch result {
            case .success(var favorites):
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completed(.alreadyInFavotires)
                        return
                    }
                    favorites.append(favorite)
                case .remove:
                    favorites.removeAll(where: {
                        $0.login == favorite.login
                    })
                }
                
                completed(save(favorites: favorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFolower(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let favoritesData = userDefault.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decode = JSONDecoder()
            let favorites = try decode.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> GFError? {
        
        do {
            let encode = JSONEncoder()
            let favoritesEncode = try encode.encode(favorites)
            userDefault.set(favoritesEncode, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
