//
//  Shaadi_comApp.swift
//  Shaadi.com
//
//  Created by Dhawal Mahajan on 24/07/24.
//

import SwiftUI

@main
struct Shaadi_comApp: App {
    let coreDataManager = CoreDataManager.shared

    var body: some Scene {
        WindowGroup {
            ProfileListView()
                .environment(\.managedObjectContext, coreDataManager.container.viewContext)
        }
    }
}
