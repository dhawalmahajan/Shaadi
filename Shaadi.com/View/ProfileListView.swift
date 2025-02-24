import SwiftUI

struct ProfileListView: View {
    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.profiles, id: \.id) { profile in
                    HStack {
                        AsyncImage(url: URL(string: profile.imageUrl ?? "")) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())

                        VStack(alignment: .leading) {
                            Text(profile.name ?? "Unknown")
                                .font(.headline)
                            Text("Age: \(profile.age)")
                                .font(.subheadline)
                        }

                        Spacer()

                        Button(action: {
                            viewModel.updateProfile(profile, isLiked: !profile.isLiked, isSelected: profile.isSelected)
                        }) {
                            Image(systemName: profile.isLiked ? "heart.fill" : "heart")
                                .foregroundColor(.red)
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        let profile = viewModel.profiles[index]
                        viewModel.deleteProfile(profile)
                    }
                }
            }
            .navigationTitle("Profiles")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Clear All") {
                        viewModel.deleteAllProfiles()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Refresh") {
                        Task {
                            await viewModel.fetchProfilesFromAPI()
                        }
                    }
                }
            }
        }
    }
}
