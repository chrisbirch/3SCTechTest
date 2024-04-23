import SwiftUI

struct PokemonDetailView: View {
    @Binding var pokemonUIItem: PokemonUIItem
    enum ViewState {
        case downloading
        case error(Error)
        case downloaded(Pokemon)
    }
    @State private var viewState: ViewState = .downloading
    
    var body: some View {
        VStack {
            Text("Detail for: \(pokemonUIItem.name)")
                .onAppear() {
                    downloadPokemon()
                }
            switch viewState {
            case .downloading:
                DownloadingView()
            case .downloaded(let pokemon):
                
                PokemonStatsView(pokemon: .constant(pokemon))
                PokemonSpritesView(pokemon: .constant(pokemon))
            case .error(let error):
                ErrorView(error: error) {
                    downloadPokemon()
                }
            }
            Spacer()
        }
        .onChange(of: pokemonUIItem) { newValue in
            downloadPokemon()
        }
    }
    
    private func downloadPokemon() {
        Task {
            do {
                let pokemon = try await pokemonUIItem.downloadPokemon()
                await MainActor.run {
                    viewState = .downloaded(pokemon)
                }
                
            } catch {
                await MainActor.run {
                    viewState = .error(error)
                }
            }
        }
    }
}
