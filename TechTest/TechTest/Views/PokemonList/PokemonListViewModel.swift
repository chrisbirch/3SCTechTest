import Foundation

extension PokemonListView {
    class ViewModel: ObservableObject {
        enum State {
            case showList([PokemonUIItem])
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
        private var allPokemonUIItems: [PokemonUIItem] = []

        private var task: Task<(), Never>?

        private func filter(searchText: String) {
            guard case .showList = state else { return }
            guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
                state = .showList(allPokemonUIItems)
                return
            }
            let filteredPokemonUIItems = allPokemonUIItems.filter { pokemon in
                pokemon.name.lowercased().contains(searchText.lowercased())
            }
            state = .showList(filteredPokemonUIItems)
        }

        func downloadList() {
            state = .downloading
            allPokemonUIItems = []
            task?.cancel()
            task = Task {
                do {
                    let pokemonItems = try await pokemonService.pokemonList()
                    
                    await MainActor.run {
                        self.allPokemonUIItems = pokemonItems.map { pokemon in
                            .init(name: pokemon.name)
                        }
                        self.state = .showList(self.allPokemonUIItems)
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
