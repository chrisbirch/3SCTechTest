import SwiftUI
import Kingfisher

/// View used for both iPhone and iPad to display sprites for the selected pokemon
struct PokemonSpritesView: View {
    @Binding var pokemon: Pokemon
    
    private var spriteImageSquareSize: CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 200
        } else {
            return 80
        }
    }
    private func imageView(label: String, url: URL) -> some View {
        VStack {
            Text("Name: \(label)")
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
            }.padding(.horizontal, .spacer16)
            ScrollView(.horizontal) {
                
                HStack {
                    ForEach(pokemon.sprites.all, id: \.self) { url in
                       imageView(label: "Unknown", url: url)
                            .padding(.spacer8)
                            .background {
                                Color.spriteBackgroundColour
                            }.cornerRadius(.spacer8)
                    }
                }.padding()
            }
        }
    }
}
