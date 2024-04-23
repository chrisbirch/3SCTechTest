import SwiftUI
import Kingfisher

/// View used for both iPhone and iPad to display sprites for the selected pokemon
struct PokemonSpritesView: View {
    let pokemon: Pokemon
    
    private var spriteImageSquareSize: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 200
        } else {
            return 80
        }
    }
    private func imageView(label: String, url: URL) -> some View {
        VStack {
            if !label.contains("\n") {
                Text("Standard\n\(label)")
                    .multilineTextAlignment(.center)
                    .font(.caption)
            } else {
                Text(label)
                    .multilineTextAlignment(.center)
                    .font(.caption)
            }
            
            let imageSize = spriteImageSquareSize
            ImageDownloaderView(width: imageSize, height: imageSize, url: .constant(url))
                .onAppear {
                    print("Image downloader appear \(url)")
                }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Sprites")
                    .font(.headline)
                Spacer()
            }.padding(.horizontal, .spacer16)
            ScrollView(.horizontal) {
                
                HStack {
                    ForEach(pokemon.sprites.all, id: \.self) { sprite in
                        if let url = sprite.url {
                            imageView(label: sprite.name, url: url)
                                .padding(.spacer8)
                                .background {
                                    Color.spriteBackgroundColour
                                }.cornerRadius(.spacer8)
                        }
                    }
                }.padding()
            }
        }
    }
}
