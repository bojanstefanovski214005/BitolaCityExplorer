import SwiftUI

struct MainTabView: View {
    @StateObject private var locationService = LocationService()

    private let appGreen = Color(
        red: 0.05,
        green: 0.48,
        blue: 0.28
    )

    var body: some View {
        TabView {
            NavigationStack {
                HomeScreen()
            }
            .tabItem {
                Label("Почетна", systemImage: "house.fill")
            }

            NavigationStack {
                MapScreen()
            }
            .tabItem {
                Label("Мапа", systemImage: "map.fill")
            }

            NavigationStack {
                FavoritesScreen()
            }
            .tabItem {
                Label("Омилени", systemImage: "heart.fill")
            }

            NavigationStack {
                SettingsScreen()
            }
            .tabItem {
                Label("Поставки", systemImage: "gearshape.fill")
            }
        }
        .tint(appGreen)
        .environmentObject(locationService)
        .task {
            locationService.requestPermission()
        }
    }
}
