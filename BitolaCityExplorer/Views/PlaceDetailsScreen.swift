import SwiftUI
import SwiftData

struct PlaceDetailsScreen: View {
    let place: Place

    @EnvironmentObject private var locationService: LocationService
    @Environment(\.modelContext) private var modelContext
    @Query private var favorites: [FavoritePlace]

    @State private var weather: WeatherInfo?
    @State private var isLoadingWeather = false
    @State private var weatherError: String?
    @State private var notificationMessage: String?
    @State private var storageError: String?

    private let weatherService = WeatherAPIService()

    private let appGreen = Color(
        red: 0.05,
        green: 0.48,
        blue: 0.28
    )

    private var isFavorite: Bool {
        StorageService.isFavorite(place, favorites: favorites)
    }

    var body: some View {
        GeometryReader { geometry in

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // MARK: - Image
                    RemotePlaceImage(imageURL: place.imageURL)
                        .frame(
                            width: geometry.size.width - 20,
                            height: 270
                        )
                        .clipped()
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 24,
                                style: .continuous
                            )
                        )

                    // MARK: - Place Info
                    VStack(alignment: .leading, spacing: 10) {

                        HStack(alignment: .top) {

                            VStack(alignment: .leading, spacing: 5) {

                                Text(place.name)
                                    .font(.largeTitle.bold())

                                Text(place.category)
                                    .font(.headline)
                                    .foregroundStyle(appGreen)
                            }

                            Spacer()

                            Button(action: toggleFavorite) {
                                Image(
                                    systemName: isFavorite
                                    ? "heart.fill"
                                    : "heart"
                                )
                                .font(.title2)
                                .foregroundStyle(
                                    isFavorite
                                    ? .red
                                    : .primary
                                )
                                .padding(10)
                                .background(
                                    .thinMaterial,
                                    in: Circle()
                                )
                            }
                        }

                        Label(
                            place.address,
                            systemImage: "mappin.and.ellipse"
                        )
                        .foregroundStyle(.secondary)

                        if let distance = MapService.distanceString(
                            from: locationService.location,
                            to: place
                        ) {
                            Label(
                                "Оддалеченост: \(distance)",
                                systemImage: "figure.walk"
                            )
                            .foregroundStyle(.secondary)
                        }

                        Text(place.description)
                            .font(.body)
                            .padding(.top, 4)
                    }
                    .frame(
                        width: geometry.size.width - 20,
                        alignment: .leading
                    )

                    // MARK: - Weather
                    weatherCard
                        .frame(
                            width: geometry.size.width - 20
                        )

                    // MARK: - Buttons
                    VStack(spacing: 12) {

                        NavigationLink {
                            CameraScreen(placeName: place.name)
                        } label: {
                            Label(
                                "Фотографирај го местото",
                                systemImage: "camera.fill"
                            )
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .controlSize(.large)

                        Button {
                            scheduleNotification()
                        } label: {
                            Label(
                                "Mock нотификација за 5 секунди",
                                systemImage: "bell.badge.fill"
                            )
                            .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.bordered)
                        .controlSize(.large)
                    }
                    .frame(
                        width: geometry.size.width - 20
                    )
                }
                .frame(
                    width: geometry.size.width,
                    alignment: .center
                )
                .padding(.top, 10)
                .padding(.bottom, 100)
            }
        }
        .navigationTitle("Детали")
        .navigationBarTitleDisplayMode(.inline)
        .tint(appGreen)

        .task(id: place.id) {
            await loadWeather()
        }

        .alert(
            "Информација",
            isPresented: Binding(
                get: {
                    notificationMessage != nil
                },
                set: {
                    if !$0 {
                        notificationMessage = nil
                    }
                }
            )
        ) {
            Button("Во ред", role: .cancel) {}
        } message: {
            Text(notificationMessage ?? "")
        }

        .alert(
            "Грешка при зачувување",
            isPresented: Binding(
                get: {
                    storageError != nil
                },
                set: {
                    if !$0 {
                        storageError = nil
                    }
                }
            )
        ) {
            Button("Во ред", role: .cancel) {}
        } message: {
            Text(storageError ?? "")
        }
    }

    // MARK: - Weather Card

    private var weatherCard: some View {
        GroupBox {

            HStack(spacing: 16) {

                if isLoadingWeather {

                    ProgressView()
                        .tint(appGreen)

                    Text("Се вчитува времето...")
                        .foregroundStyle(.secondary)

                } else if let weather {

                    Image(systemName: weather.systemImage)
                        .font(.system(size: 34))
                        .symbolRenderingMode(.multicolor)

                    VStack(
                        alignment: .leading,
                        spacing: 3
                    ) {

                        Text(
                            "\(weather.temperature, specifier: "%.1f") °C"
                        )
                        .font(.title2.bold())

                        Text(weather.description)

                        Text(
                            "Се чувствува како \(weather.apparentTemperature, specifier: "%.1f") °C"
                        )
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    }

                } else {

                    Image(
                        systemName: "exclamationmark.triangle.fill"
                    )
                    .foregroundStyle(.orange)

                    Text(
                        weatherError
                        ?? "Нема податоци за временска прогноза."
                    )
                    .foregroundStyle(.secondary)
                }

                Spacer()
            }
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )

        } label: {

            Label(
                "Временска прогноза (API)",
                systemImage: "cloud.sun.fill"
            )
        }
    }

    // MARK: - Load Weather

    private func loadWeather() async {

        isLoadingWeather = true
        weatherError = nil

        defer {
            isLoadingWeather = false
        }

        do {

            weather = try await weatherService.fetchWeather(
                latitude: place.latitude,
                longitude: place.longitude
            )

        } catch {

            weatherError = error.localizedDescription
        }
    }

    // MARK: - Favorite

    private func toggleFavorite() {

        do {

            try StorageService.toggleFavorite(
                place: place,
                context: modelContext
            )

        } catch {

            storageError = error.localizedDescription
        }
    }

    // MARK: - Notification

    private func scheduleNotification() {

        Task {

            do {

                try await NotificationService.shared
                    .scheduleMockNotification(
                        placeName: place.name
                    )

                notificationMessage =
                "Нотификацијата е закажана. Ќе се појави за околу 5 секунди."

            } catch {

                notificationMessage =
                error.localizedDescription
            }
        }
    }
}
