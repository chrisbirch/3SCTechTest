import SwiftUI

struct PokemonListView: View {
    @StateObject private var viewModel: ViewModel
    @EnvironmentObject private var applicationViewModel: ApplicationViewModel
    init() {
        _viewModel = StateObject(wrappedValue: ViewModel())
    }
    
    var body: some View {
        switch viewModel.state {
        case .downloading:
            DownloadingView()
        case .error(let error):
            ErrorView(error: error) {
                viewModel.downloadList()
            }
        case .showList(let filteredItems):
            
            ScrollView {
                LazyVStack {
                    ForEach(filteredItems) { pokemonUIItem in
                        ListItemView(pokemonUIItem: pokemonUIItem)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                withAnimation {
                                    applicationViewModel.naviagtionPath += [pokemonUIItem]
                                }
                            }
                    }
                }
            }.searchable(text: $viewModel.searchText)
        }
    }
}
