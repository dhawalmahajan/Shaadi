//
//  ProfileCardView.swift
//  Shaadi.com
//
//  Created by Dhawal Mahajan on 24/02/25.
//

import SwiftUI

struct ProfileCardView: View {
    let profile: Profile
    @ObservedObject var viewModel: ProfileViewModel

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: profile.imageUrl ?? "")) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Color.gray
            }
            .frame(width: 120, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            Text(profile.name ?? "Unknown")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.blue)

            Text("\(profile.age), \(profile.address ?? "Unknown")")
                .font(.subheadline)
                .foregroundColor(.gray)
            if !profile.isSelected {
                HStack(spacing: 30) {
                    Button(action: {
                        viewModel.updateProfile(profile, isLiked: false, isSelected: true)
                    }) {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.red)
                    }
                    
                    Button(action: {
                        viewModel.updateProfile(profile, isLiked: true, isSelected: true)
                    }) {
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.top, 8)
            }

            if profile.isSelected {
                Text(profile.isLiked ? "Accepted" : "Declined")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(profile.isLiked ? Color.blue : Color.red)
                    .cornerRadius(10)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(Color.white).shadow(radius: 4))
        .padding(.horizontal, 16)
    }
}

