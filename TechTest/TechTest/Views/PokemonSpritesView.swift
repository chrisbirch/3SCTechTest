import SwiftUI
import Kingfisher

struct PokemonSpritesView: View {
    @Binding var pokemon: Pokemon
    
    private func imageView(label: String, url: URL) -> some View {
        VStack {
            Text("Name: \(label)")
            KFImage(url)
        }
        
        
    }
    var body: some View {
        VStack {
            Text("Sprites:")
            ScrollView(.horizontal) {
                
                HStack {
                    ForEach(pokemon.sprites.all, id: \.self) { url in
                       imageView(label: "Unknown", url: url)
                        .padding(10)
                        .background {
                            Color.green
                        }
                    }
                }.padding()
            }
        }
    }
}
