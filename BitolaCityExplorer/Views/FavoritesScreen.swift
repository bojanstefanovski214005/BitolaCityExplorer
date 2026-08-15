import SwiftUI
import SwiftData

struct FavoritesScreen: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \FavoritePlace.name) private var favorites: [FavoritePlace]
    @StateObject private var authService = AuthService()
    @State private var deleteError: String?

    var body: some View {
        Group {
            if authService.isAuthenticated {
                favoritesContent
            } else {
                lockedContent
            }
        }
        .navigationTitle("Омилени")
        .toolbar {
            if authService.isAuthenticated {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Заклучи") {
                        authService.lock()
                    }
                }
            }
        }
        .alert("Грешка", isPresented: Binding(
            get: { deleteError != nil },
            set: { if !$0 { deleteError = nil } }
        )) {
            Button("Во ред", role: .cancel) {}
        } message: {
            Text(deleteError ?? "")
        }
    }

    private var lockedContent: some View {
        ContentUnavailableView {
            Label("Омилените се заклучени", systemImage: "faceid")
        } description: {
            Text(authService.errorMessage ?? "Користи FaceID за пристап до зачуваните места.")
        } actions: {
            Button {
                Task { await authService.authenticateWithFaceID() }
            } label: {
                if authService.isAuthenticating {
                    ProgressView()
                } else {
                    Label("Отклучи со FaceID", systemImage: "faceid")
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(authService.isAuthenticating)
        }
    }

    @ViewBuilder
    private var favoritesContent: some View {
        if favorites.isEmpty {
            ContentUnavailableView(
                "Нема омилени места",
                systemImage: "heart.slash",
                description: Text("Додај место во омилени од почетниот екран или од деталите.")
            )
        } else {
            List {
                ForEach(favorites) { favorite in
                    NavigationLink {
                        PlaceDetailsScreen(place: favorite.asPlace)
                    } label: {
                        HStack(spacing: 12) {
                            RemotePlaceImage(imageURL: favorite.imageURL)
                                .frame(width: 74, height: 58)
                                .clipped()
                                .clipShape(RoundedRectangle(cornerRadius: 10))

                            VStack(alignment: .leading, spacing: 4) {
                                Text(favorite.name)
                                    .font(.headline)
                                Text(favorite.category)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteFavorites)
            }
        }
    }

    private func deleteFavorites(at offsets: IndexSet) {
        do {
            for index in offsets {
                try StorageService.deleteFavorite(favorites[index], context: modelContext)
            }
        } catch {
            deleteError = error.localizedDescription
        }
    }
}
