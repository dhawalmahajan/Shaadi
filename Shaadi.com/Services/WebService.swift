//
//  WebService.swift
//  Shaadi.com
//
//  Created by Dhawal Mahajan on 26/07/24.
//

import Foundation
import CoreData
class WebService {
    static let shared = WebService()
    
    private init() {}
    
    func fetchCards(completion: @escaping (Result<UserInfo, Error>) -> Void) {
        guard let url = URL(string: kWEB_URL) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            
            do {
                let cards = try JSONDecoder().decode(UserInfo.self, from: data)
                completion(.success(cards))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}

extension WebService {
    func saveCardsToCoreData(cards: [Profile], context: NSManagedObjectContext) {
        context.perform {
            for profileData in cards {
                
                let fetchRequest: NSFetchRequest<Profile> = Profile.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %@", profileData.id ?? "" as CVarArg)
                do {
                    let existingCards = try context.fetch(fetchRequest)
                    if existingCards.isEmpty {
                        let card = Profile(context: context)
                        card.id = profileData.id
                        card.name = profileData.name
                        card.age = profileData.age
                        card.isLiked = false // Default value
                        card.isSelected = false
                        try context.save()
                    }
                }
                catch {
                    print("Failed to fetch profile: \(error)")
                }
            }
        }
    }
}
