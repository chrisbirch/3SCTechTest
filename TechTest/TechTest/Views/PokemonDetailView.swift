import SwiftUI


/// Main view used for both iPhone and iPad to display details about the selected pokemon
struct PokemonDetailView: View {
    @ObservedObject private var viewModel: PokemonDetailViewModel
    
    init(pokemonName: String) {
        _viewModel = ObservedObject(wrappedValue: PokemonDetailViewModel(pokemonName: pokemonName))
    }
    var body: some View {
        VStack {
            switch viewModel.viewState {
            case .downloading:
                DownloadingView()
                    .onAppear {
                               viewModel.downloadPokemon()
                           }
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
                }.onAppear {
                    print("Downloaded view appeaing for \(pokemon.name)")
                }
            case .error(let error):
                ErrorView(error: error) {
                    viewModel.downloadPokemon()
                }
            }
            Spacer()
        }.padding()
        .navigationTitle(viewModel.pokemonName.capitalized)

        
//        .onChange(of: viewModel) {
//            print("View model changed")
//        }
//        .onChange(of: pokemonName) { newPokemonName in
//            _viewModel = .init(pokemonName: newPokemonName)
//            print("Pokemon changed '\(newPokemonName)")
//        }
    }
}
