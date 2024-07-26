//
//  ProfileCard.swift
//  Shaadi.com
//
//  Created by Dhawal Mahajan on 24/07/24.
//

import SwiftUI

struct ProfileCard: View {
    @State var profile: Profile
    @ObservedObject var viewModel:CardLitsViewModel
    
    var body: some View {
        return  VStack(alignment: .center,spacing: 10) {
            Spacer()
            if let image = profile.imageUrl, let url = URL(string: image) {
                AsyncImage(url: url)
                    .frame(width: 100,height: 100)
                    .shadow(radius: 5)
            } else {
                ProgressView()
            }
            Text(profile.name ?? "")
                .font(.headline)
                .padding(.top, 8)
            
            Text("\(profile.age) \(profile.address ?? "")")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 8)
            
            Spacer()
            if profile.isSelected  {
                
                Text((profile.isLiked) ? "Accepted" : "Rejected")
                
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.blue)
                    .cornerRadius(5)
                
            } else {
                
                HStack(spacing: 30) {
                    Button(action: {
                        viewModel.updateCardStatus(for: profile, isLiked: false)
                    }) {
                        Image(systemName: "person.fill.xmark")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Circle().fill(Color.red))
                    }
                    Spacer()
                    Button(action: {
                        viewModel.updateCardStatus(for: profile, isLiked: true)
                    }) {
                        Image(systemName: "checkmark")
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Circle().fill(Color.green))
                    }
                }
                .padding(16)
            }
            
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 5)
        .padding(16)
    }
}

//#Preview {
//    ProfileCard(profile: Pro, viewModel: CardLitsViewModel())
//}
