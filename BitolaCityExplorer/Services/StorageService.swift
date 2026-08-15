import Foundation
import SwiftData

enum StorageService {
    static func favorite(for placeID: UUID, context: ModelContext) throws -> FavoritePlace? {
        let allFavorites = try context.fetch(FetchDescriptor<FavoritePlace>())
        return allFavorites.first { $0.id == placeID }
    }

    static func isFavorite(_ place: Place, favorites: [FavoritePlace]) -> Bool {
        favorites.contains { $0.id == place.id }
    }

    static func toggleFavorite(place: Place, context: ModelContext) throws {
        if let existing = try favorite(for: place.id, context: context) {
            context.delete(existing)
        } else {
            context.insert(FavoritePlace(place: place))
        }
        try context.save()
    }

    static func deleteFavorite(_ favorite: FavoritePlace, context: ModelContext) throws {
        context.delete(favorite)
        try context.save()
    }
}
