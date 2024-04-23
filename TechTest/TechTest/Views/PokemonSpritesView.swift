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
    private func imageView(categoryLabel: String, label: String, url: URL) -> some View {
        VStack {
            Text(categoryLabel)
                .font(.caption)
                .bold()
            Text(label)
                .multilineTextAlignment(.center)
                .font(.caption)
                .lineLimit(2)
            
            
            let imageSize = spriteImageSquareSize
            ImageDownloaderView(width: imageSize, height: imageSize, url: url)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Sprites")
                    .font(.headline)
                Spacer()
            }.padding(.horizontal, .spacer4)
            ScrollView(.horizontal) {
                
                HStack {
                    ForEach(pokemon.sprites.all, id: \.self) { sprite in
                        if let url = sprite.url {
                            imageView(categoryLabel: sprite.cateogryName, label: sprite.name, url: url)
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
