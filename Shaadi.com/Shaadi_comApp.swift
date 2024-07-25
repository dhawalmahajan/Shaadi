//
//  Shaadi_comApp.swift
//  Shaadi.com
//
//  Created by Dhawal Mahajan on 24/07/24.
//

import SwiftUI

@main
struct Shaadi_comApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            CardListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
