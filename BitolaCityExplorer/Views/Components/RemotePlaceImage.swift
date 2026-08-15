import SwiftUI
import Kingfisher

struct RemotePlaceImage: View {
    let imageURL: String

    var body: some View {
        if let url = URL(string: imageURL) {
            KFImage(url)
                .placeholder {
                    ZStack {
                        Rectangle().fill(.quaternary)
                        ProgressView()
                    }
                }
                .fade(duration: 0.25)
                .cacheOriginalImage()
                .resizable()
                .scaledToFill()
        } else {
            ZStack {
                Rectangle().fill(.quaternary)
                Image(systemName: "photo")
                    .font(.largeTitle)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
