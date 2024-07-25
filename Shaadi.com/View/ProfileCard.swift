//
//  ProfileCard.swift
//  Shaadi.com
//
//  Created by Dhawal Mahajan on 24/07/24.
//

import SwiftUI

struct ProfileCard: View {
    @State var profile: Profile?
    @ObservedObject var viewModel:CardLitsViewModel
    var body: some View {

            
            VStack(alignment: .center,spacing: 10) {
                if let image = profile?.imageUrl, let url = URL(string: image) {
                    AsyncImage(url: url)
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fill)
                }
                Text("\($profile.wrappedValue?.name ?? "")")
                    .font(.headline)
                    .padding(.top, 8)
                
                Text("\($profile.wrappedValue?.age ?? 0)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 8)
                
                HStack(spacing: 30) {
                    Button(action: rejectProfile) {
                        Image(systemName: "person.fill.xmark")
                            .font(.subheadline)
                            .foregroundColor($profile.wrappedValue?.isLiked ?? false ? .red : .black)
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                        
                    }
                    
                    Button(action: selectProfile) {
                        Image(systemName: "checkmark")
                            .font(.subheadline)
                            .foregroundColor($profile.wrappedValue?.isLiked ?? false ? .green :.black)
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                }
                .padding(.top, 16)
//                if profile.isLiked != true && profile.isLiked != false {
//                   
//                } else {
//                    Button(action: {}) {
//                        Text(profile.isLiked ? "Accepted" : "Rejected")
//                    }
//                }
               

            }
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 5)
            .padding(.horizontal, 20)
        }
    
    
    private func selectProfile() {
        profile = viewModel.updateProfile(id: profile?.id ?? "", isLiked: true)
    }
    
    private func rejectProfile() {
        profile =  viewModel.updateProfile(id: profile?.id ?? "", isLiked: false)
    }
}

//#Preview {
//    ProfileCard(profile: .placeholderProfile, viewModel: CardLitsViewModel(webService: .init(url: kWEB_URL), coreDataManager: .init()))
//}
