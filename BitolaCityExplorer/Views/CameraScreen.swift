import SwiftUI
import UIKit

struct CameraScreen: View {
    let placeName: String

    @State private var capturedImage: UIImage?
    @State private var showCamera = false

    var body: some View {
        VStack(spacing: 22) {
            if let capturedImage {
                Image(uiImage: capturedImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 22))
                    .shadow(radius: 8)
            } else {
                ContentUnavailableView(
                    "Нема фотографија",
                    systemImage: "camera",
                    description: Text("Фотографирај го местото „\(placeName)“ со камерата на уредот.")
                )
            }

            if CameraService.isCameraAvailable {
                Button {
                    showCamera = true
                } label: {
                    Label(capturedImage == nil ? "Отвори камера" : "Фотографирај повторно", systemImage: "camera.fill")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            } else {
                Label("Камерата не е достапна во овој Simulator. Тестирај на физички iPhone.", systemImage: "iphone.slash")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
        .navigationTitle("Камера")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showCamera) {
            CameraPicker(selectedImage: $capturedImage)
                .ignoresSafeArea()
        }
    }
}
