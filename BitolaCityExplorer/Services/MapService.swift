import Foundation
import MapKit
import CoreLocation

enum MapService {
    static let bitolaRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 41.0297, longitude: 21.3292),
        span: MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06)
    )

    static func region(around coordinate: CLLocationCoordinate2D, delta: Double = 0.015) -> MKCoordinateRegion {
        MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        )
    }

    static func distanceString(from userLocation: CLLocation?, to place: Place) -> String? {
        guard let userLocation else { return nil }
        let target = CLLocation(latitude: place.latitude, longitude: place.longitude)
        let meters = userLocation.distance(from: target)

        if meters < 1_000 {
            return "\(Int(meters.rounded())) m"
        }
        return String(format: "%.1f km", meters / 1_000)
    }
}
