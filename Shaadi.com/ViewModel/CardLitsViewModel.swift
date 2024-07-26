//
//  CardLitsViewModel.swift
//  Shaadi.com
//
//  Created by Dhawal Mahajan on 24/07/24.
//

import Foundation
import CoreData


@MainActor
class CardLitsViewModel: ObservableObject {
    
    private let coreDataManager: CoreDataManager = CoreDataManager()
    @Published var user: [Profile] = []
    
    init() {
        
        fetchCardProfile()
        
    }
    
    
    private func fetchCardProfile() {
        WebService.shared.fetchCards {  [weak self] result in
            switch result {
            case .success(let cards):
                var c:[Profile] = []
                for i in cards.results {
                    let profile = Profile(context: PersistenceController.shared.viewContext)
                    profile.id = i.login.uuid
                    profile.name = i.name.first
                    profile.age = Int16(i.dob.age)
                    profile.imageUrl = i.picture.medium
                    profile.isLiked = false
                    profile.isSelected = false
                    profile.address = i.location.city
                    c.append(profile)
                    self?.coreDataManager.saveContext()
                }
                self?.saveCards(cards: c)
                DispatchQueue.main.async {
                    self?.fetchCardsFromCoreData()
                }
            case .failure(let error):
                print("Failed to fetch cards: \(error)")
            }
        }
    }
   
    
    private func saveCards(cards: [Profile]) {
        WebService.shared.saveCardsToCoreData(cards: cards, context: PersistenceController.shared.viewContext)
    }
    
    func updateCardStatus(for card: Profile, isLiked: Bool) {
        card.isLiked = isLiked
        card.isSelected = true
        coreDataManager.saveContext()
        DispatchQueue.main.async {[weak self] in
            self?.fetchCardsFromCoreData() // Refresh the cards array
        }
    }
    private func fetchCardsFromCoreData() {
        let request: NSFetchRequest<Profile> = Profile.fetchRequest()
        
        do {
            self.user = try PersistenceController.shared.viewContext.fetch(request)
        } catch {
            print("Failed to fetch cards from Core Data: \(error)")
        }
    }
}
