import SwiftUI

/// View model for the pokemon details view
class PokemonDetailViewModel: ObservableObject {
    enum ViewState {
        case downloading
        case error(Error)
        case downloaded(Pokemon)
    }
    
    @Inject private var pokemonService: PokemonService
    @Published var viewState: ViewState
    @Published var pokemonName: String
    private var task: Task<(), Never>?
    
    init(pokemonName: String) {
        self.pokemonName = pokemonName
        viewState = .downloading
    }
    
    func downloadPokemon() {
        task?.cancel()
        task = Task {
            do {
                let pokemon = try await pokemonService.pokemon(named: pokemonName)
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
