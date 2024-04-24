import Foundation

extension PokemonListView {
    class ViewModel: ObservableObject {
        enum State {
            case showList([String])
            case error(Error)
            case downloading
        }
        
        @Inject private var pokemonService: PokemonService
        @Published private(set) var state: State = .downloading
        
        @Published var searchText = "" {
            didSet {
                filter(searchText: searchText.lowercased())
            }
        }
        private var allPokemonNames: [String] = []
        
        private var task: Task<(), Never>?
        
        private func filter(searchText: String) {
            guard case .showList = state else { return }
            guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
                state = .showList(allPokemonNames)
                return
            }
            let filteredPokemons = allPokemonNames.filter { pokemonName in
                pokemonName.lowercased().contains(searchText.lowercased())
            }
            state = .showList(filteredPokemons)
        }
        
        func downloadList() {
            state = .downloading
            allPokemonNames = []
            task?.cancel()
            task = Task {
                do {
                    let pokemonItems = try await pokemonService.pokemonList()
                    
                    await MainActor.run {
                        self.allPokemonNames = pokemonItems.map { pokemon in
                            pokemon.name
                        }
                        self.state = .showList(self.allPokemonNames)
                        self.filter(searchText: searchText)
                    }
                } catch {
                    await MainActor.run {
                        self.state = .error(error)
                    }
                }
            }
        }
        
        init() {
            downloadList()
        }
    }
}
