//
//  ContentView.swift
//  Shaadi.com
//
//  Created by Dhawal Mahajan on 24/07/24.
//

import SwiftUI
import CoreData

struct CardListView: View {
    @StateObject  var viewModel: CardLitsViewModel = CardLitsViewModel()
//    @Environment(\.managedObjectContext) private var viewContext
    init() {
        
    }

    var body: some View {
        NavigationView {
            
            List {
                if let user = viewModel.user {
                    ForEach(user) { item in
                        ProfileCard(profile: item, viewModel: viewModel)
                            .listRowBackground(Color.clear) // Disable row selection highlight
                                               .listRowSeparator(.hidden) // Remove separators
                                               .background(Color.clear)
                    }
                    .listRowInsets(EdgeInsets())
                    
                }
            }
            .listStyle(PlainListStyle())
            
           
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
    CardListView()
}
