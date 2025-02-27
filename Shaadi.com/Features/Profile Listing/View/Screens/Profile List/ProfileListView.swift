import SwiftUI

struct ProfileListView: View {
    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Profile Matches")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                    LazyVStack {
                        ForEach(viewModel.profiles, id: \.id) { profile in
                            ProfileCardView(profile: profile, viewModel: viewModel)
                        }
                    }
                }
                .padding()
            }
            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
//            .navigationTitle("Profiles")
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

