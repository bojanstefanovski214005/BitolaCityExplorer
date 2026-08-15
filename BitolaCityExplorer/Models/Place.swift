import Foundation
import CoreLocation

struct Place: Identifiable, Hashable {
    let id: UUID
    let name: String
    let description: String
    let address: String
    let category: String
    let latitude: Double
    let longitude: Double
    let imageURL: String

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
