import SwiftUI


/// Main view used for both iPhone and iPad to display details about the selected pokemon
struct PokemonDetailView: View {
    @ObservedObject private var viewModel: PokemonDetailViewModel
    
    init(pokemonName: String) {
        _viewModel = ObservedObject(wrappedValue: PokemonDetailViewModel(pokemonName: pokemonName))
    }
    var body: some View {
        VStack {
            Text("Detail for: \(viewModel.pokemonName)")
            switch viewModel.viewState {
            case .downloading:
                DownloadingView()
            case .downloaded(let pokemon):
                
                PokemonStatsView(pokemon: .constant(pokemon))
                PokemonSpritesView(pokemon: .constant(pokemon))
            case .error(let error):
                ErrorView(error: error) {
                    viewModel.downloadPokemon()
                }
            }
            Spacer()
        }
    }
}
