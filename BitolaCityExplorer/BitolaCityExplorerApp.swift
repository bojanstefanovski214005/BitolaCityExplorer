import SwiftUI
import SwiftData

@main
struct BitolaCityExplorerApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some Scene {
        WindowGroup {
            RootView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
        .modelContainer(for: FavoritePlace.self)
    }
}

private struct RootView: View {
    @State private var showingSplash = true

    var body: some View {
        ZStack {
            if showingSplash {
                SplashScreen()
                    .transition(.opacity.combined(with: .scale(scale: 1.04)))
            } else {
                MainTabView()
                    .transition(.opacity)
            }
        }
        .task {
            guard showingSplash else { return }
            try? await Task.sleep(nanoseconds: 1_800_000_000)
            withAnimation(.easeInOut(duration: 0.35)) {
                showingSplash = false
            }
        }
    }
}
