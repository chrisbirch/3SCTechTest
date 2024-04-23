import SwiftUI


/// Main view used for both iPhone and iPad to display details about the selected pokemon
struct PokemonDetailView: View {
    @ObservedObject private var viewModel: PokemonDetailViewModel
    
    init(pokemonName: String) {
        _viewModel = ObservedObject(wrappedValue: PokemonDetailViewModel(pokemonName: pokemonName))
    }
    var body: some View {
        VStack {
            Text(viewModel.pokemonName.capitalized)
                .font(.largeTitle)
            switch viewModel.viewState {
            case .downloading:
                DownloadingView()
            case .downloaded(let pokemon):
                
                PokemonStatsView(pokemon: .constant(pokemon))
                    .padding(.spacer8)
                    .background {
                        Color.detailSectionBackgroundColour
                    }.cornerRadius(.spacer8)
                PokemonSpritesView(pokemon: .constant(pokemon))
                    .padding(.spacer8)
                    .background {
                        Color.detailSectionBackgroundColour
                    }.cornerRadius(.spacer8)
            case .error(let error):
                ErrorView(error: error) {
                    viewModel.downloadPokemon()
                }
            }
            Spacer()
        }
    }
}
