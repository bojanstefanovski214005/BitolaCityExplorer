import SwiftUI
import MapKit

struct MapScreen: View {
    @EnvironmentObject private var locationService: LocationService
    @State private var position: MapCameraPosition = .region(MapService.bitolaRegion)
    @State private var selectedPlace: Place?

    private let appGreen = Color(
        red: 0.05,
        green: 0.48,
        blue: 0.28
    )

    var body: some View {
        Map(position: $position) {
            UserAnnotation()

            ForEach(SamplePlaces.all) { place in
                Annotation(place.name, coordinate: place.coordinate) {
                    Button {
                        selectedPlace = place
                    } label: {
                        Image(systemName: "mappin.circle.fill")
                            .font(.system(size: 34))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white, appGreen)
                            .shadow(radius: 3)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .mapControls {
            MapCompass()
            MapScaleView()
            MapUserLocationButton()
        }
        .navigationTitle("Мапа")
        .tint(appGreen)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    centerOnUser()
                } label: {
                    Image(systemName: "location.fill")
                }
                .accessibilityLabel("Прикажи ја мојата локација")
            }
        }
        .navigationDestination(item: $selectedPlace) { place in
            PlaceDetailsScreen(place: place)
        }
    }

    private func centerOnUser() {
        locationService.refreshLocation()

        if let coordinate = locationService.location?.coordinate {
            withAnimation {
                position = .region(
                    MapService.region(around: coordinate)
                )
            }
        }
    }
}
