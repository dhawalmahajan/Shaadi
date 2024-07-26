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
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(viewModel.user) { item in
                    ProfileCard(profile: item, viewModel: viewModel)
                        .listRowBackground(Color.clear) // Disable row selection highlight
                        .listRowSeparator(.hidden) // Remove separators
//                        .background(Color.clear)
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(PlainListStyle())
            
            
        }
    }
    
}


#Preview {
    CardListView()
}
