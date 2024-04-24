import SwiftUI

/// Main view used for both iPhone and iPad to display details about the selected pokemon
struct PokemonDetailView: View {
    @ObservedObject private var viewModel: PokemonDetailViewModel
    
    init(pokemonName: String) {
        _viewModel = ObservedObject(wrappedValue: PokemonDetailViewModel(pokemonName: pokemonName))
        viewModel.downloadPokemon()
    }
    var body: some View {
        VStack {
            switch viewModel.viewState {
            case .idle, .downloading:
                DownloadingView()
            case .downloaded(let pokemon):
                VStack(spacing: .spacer16) {
                    PokemonStatsView(pokemon: pokemon)
                        .padding(.spacer8)
                        .background {
                            Color.detailSectionBackgroundColour
                        }.cornerRadius(.spacer8)
                    PokemonSpritesView(pokemon: pokemon)
                        .padding(.spacer8)
                        .background {
                            Color.detailSectionBackgroundColour
                        }.cornerRadius(.spacer8)
                }
            case .error(let error):
                ErrorView(error: error) {
                    viewModel.downloadPokemon()
                }
            }
            Spacer()
        }.padding()
        .navigationTitle(viewModel.pokemonName.capitalized)
    }
}
