import Foundation
import SwiftData

@Model
final class FavoritePlace: Identifiable {
    @Attribute(.unique) var id: UUID
    var name: String
    var placeDescription: String
    var address: String
    var category: String
    var latitude: Double
    var longitude: Double
    var imageURL: String
    var createdAt: Date

    init(
        id: UUID,
        name: String,
        placeDescription: String,
        address: String,
        category: String,
        latitude: Double,
        longitude: Double,
        imageURL: String,
        createdAt: Date = .now
    ) {
        self.id = id
        self.name = name
        self.placeDescription = placeDescription
        self.address = address
        self.category = category
        self.latitude = latitude
        self.longitude = longitude
        self.imageURL = imageURL
        self.createdAt = createdAt
    }

    convenience init(place: Place) {
        self.init(
            id: place.id,
            name: place.name,
            placeDescription: place.description,
            address: place.address,
            category: place.category,
            latitude: place.latitude,
            longitude: place.longitude,
            imageURL: place.imageURL
        )
    }

    var asPlace: Place {
        Place(
            id: id,
            name: name,
            description: placeDescription,
            address: address,
            category: category,
            latitude: latitude,
            longitude: longitude,
            imageURL: imageURL
        )
    }
}
