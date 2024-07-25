//
//  ContentView.swift
//  Shaadi.com
//
//  Created by Dhawal Mahajan on 24/07/24.
//

import SwiftUI
import CoreData

struct CardListView: View {
    @StateObject  var viewModel: CardLitsViewModel = CardLitsViewModel(webService: .init(url: kWEB_URL), coreDataManager: .init())
    @Environment(\.managedObjectContext) private var viewContext


    var body: some View {
        NavigationView {
            
            List {
                if let user = viewModel.user {
                    ForEach(user) { item in
                        ProfileCard(profile: item, viewModel: viewModel)
                    }
                    .listRowInsets(EdgeInsets())
                    
                }
            }
            .listStyle(PlainListStyle())
            
           
        }.task {
          await  viewModel.fetchWebService()
        }
    }

}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    CardListView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
}
