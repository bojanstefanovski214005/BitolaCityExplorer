import SwiftUI

struct AnimatedPlaceCard: View {
    let place: Place
    let isFavorite: Bool
    let distance: String?
    let onOpen: () -> Void
    let onFavorite: () -> Void

    @State private var isPressed = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            RemotePlaceImage(imageURL: place.imageURL)
                .frame(height: 185)
                .clipped()
                .overlay(alignment: .topTrailing) {
                    Button(action: onFavorite) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .font(.headline)
                            .foregroundStyle(isFavorite ? .red : .primary)
                            .padding(11)
                            .background(.ultraThinMaterial, in: Circle())
                    }
                    .buttonStyle(.plain)
                    .padding(12)
                    .accessibilityLabel(isFavorite ? "Отстрани од омилени" : "Додај во омилени")
                }

            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .firstTextBaseline) {
                    Text(place.name)
                        .font(.title3.bold())
                    Spacer()
                    if let distance {
                        Label(distance, systemImage: "location.fill")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                Text(place.category)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.green)

                Text(place.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            .padding(16)
        }
        .background(.background)
        .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .shadow(color: .black.opacity(0.12), radius: 14, y: 7)
        .scaleEffect(isPressed ? 0.97 : 1)
        .opacity(isPressed ? 0.88 : 1)
        .animation(.spring(response: 0.28, dampingFraction: 0.68), value: isPressed)
        .contentShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
        .onTapGesture(perform: onOpen)
        .onLongPressGesture(
            minimumDuration: 0.01,
            maximumDistance: 50,
            pressing: { pressing in
                isPressed = pressing
            },
            perform: {}
        )
    }
}
