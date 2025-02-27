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

                    CardView()
                }
                .padding()
            }
            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Clear All") {
                        viewModel.deleteAllProfiles()
                        viewModel.fetchProfilesFromDB()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Refresh") {
                        Task {
                            await viewModel.fetchProfilesFromAPI(reset: true)
                        }
                    }
                }
            }
        }
    }
    private func CardView() -> some View {
        return LazyVStack {
            ForEach(viewModel.profiles.indices, id: \.self) { index in
                if index < viewModel.profiles.count {
                    let profile = viewModel.profiles[index]
                    ProfileCardView(profile: profile, viewModel: viewModel)
                        .onAppear {
                            if index == viewModel.profiles.count - 1 {
                                Task {
                                    await viewModel.fetchProfilesFromAPI()
                                }
                            }
                        }
                }
            }
        }
    }
    
}

