import SwiftUI
import SwiftData
import CoreLocation

struct HomeScreen: View {
    @EnvironmentObject private var locationService: LocationService
    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [FavoritePlace]

    @State private var selectedPlace: Place?
    @State private var storageError: String?

    private var sortedPlaces: [Place] {
        guard let userLocation = locationService.location else {
            return SamplePlaces.all
        }

        return SamplePlaces.all.sorted { first, second in
            let firstLocation = CLLocation(latitude: first.latitude, longitude: first.longitude)
            let secondLocation = CLLocation(latitude: second.latitude, longitude: second.longitude)
            return userLocation.distance(from: firstLocation) < userLocation.distance(from: secondLocation)
        }
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 18) {
                header

                ForEach(sortedPlaces) { place in
                    AnimatedPlaceCard(
                        place: place,
                        isFavorite: StorageService.isFavorite(place, favorites: favorites),
                        distance: MapService.distanceString(from: locationService.location, to: place),
                        onOpen: { selectedPlace = place },
                        onFavorite: { toggleFavorite(place) }
                    )
                }
            }
            .padding()
        }
        .navigationTitle("Bitola City Explorer")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(item: $selectedPlace) { place in
            PlaceDetailsScreen(place: place)
        }
        .alert("Грешка", isPresented: Binding(
            get: { storageError != nil },
            set: { if !$0 { storageError = nil } }
        )) {
            Button("Во ред", role: .cancel) {}
        } message: {
            Text(storageError ?? "")
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text("Откриј ја Битола")
                .font(.largeTitle.bold())
            Text(locationService.location == nil
                 ? "Дозволи локација за да ги подредиме местата според близина."
                 : "Препорачани места, подредени според твојата моментална локација.")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 6)
    }

    private func toggleFavorite(_ place: Place) {
        do {
            try StorageService.toggleFavorite(place: place, context: modelContext)
        } catch {
            storageError = error.localizedDescription
        }
    }
}
