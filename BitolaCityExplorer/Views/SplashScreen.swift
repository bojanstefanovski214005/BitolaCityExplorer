import SwiftUI

struct SplashScreen: View {
    @State private var animate = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(red: 0.05, green: 0.38, blue: 0.25),
                    Color(red: 0.10, green: 0.62, blue: 0.38)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 18) {
                ZStack {
                    Circle()
                        .fill(.white.opacity(0.16))
                        .frame(width: 132, height: 132)
                        .scaleEffect(animate ? 1.08 : 0.92)

                    Image(systemName: "mappin.and.ellipse")
                        .font(.system(size: 62, weight: .semibold))
                        .foregroundStyle(.white)
                        .rotationEffect(.degrees(animate ? 0 : -8))
                }

                Text("BITOLA")
                    .font(.system(size: 34, weight: .black, design: .rounded))
                    .tracking(4)

                Text("CITY EXPLORER")
                    .font(.headline)
                    .tracking(2)
            }
            .foregroundStyle(.white)
        }
        .onAppear {
            withAnimation(
                .spring(
                    response: 0.8,
                    dampingFraction: 0.55
                )
                .repeatForever(autoreverses: true)
            ) {
                animate = true
            }
        }
    }
}
