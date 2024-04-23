import SwiftUI
extension PokemonListView {
    struct ListItemView: View {
        enum ViewState {
            case idle
            case downloading
            case error
            case downloaded(Pokemon)
        }
        @EnvironmentObject private var applicationViewModel: ApplicationViewModel
        @Inject private var pokemonService: PokemonService
        private var imageSizeSquare: CGFloat {
            if UIDevice.current.userInterfaceIdiom == .pad {
                return 80
            } else {
                return 60
            }
        }
        let pokemonName: String
        @State var state = ViewState.idle
        var isSelected: Bool {
            applicationViewModel.selectedPokemonName == pokemonName
        }
        var noIconImageSquareSize: CGFloat {
            imageSizeSquare - 20
        }
        var noIconImage: some View {
            VStack{
                Spacer()
                HStack {
                    Spacer()
                    Image.noIcon
                        .frame(width: noIconImageSquareSize, height: noIconImageSquareSize)
                    Spacer()
                }
                Spacer()
            }.frame(width: imageSizeSquare, height: imageSizeSquare)
               
        }
        var body: some View {
            HStack(alignment: .center) {
                
                switch state {
                case .downloaded(let pokemon):
                    if let thumbnailURL = pokemon.thumbnailImageURL {
                        
                        ImageDownloaderView(
                            width: imageSizeSquare,
                            height: imageSizeSquare,
                            url: thumbnailURL
                        )
                    } else {
                        noIconImage
                    }
                case .downloading:
                    ProgressView()
                        .frame(width: noIconImageSquareSize, height: noIconImageSquareSize)
                case .error:
                    noIconImage
                case .idle:
                    noIconImage
                }
                Text("\(pokemonName.capitalized)")
                    .font(.title)
                    .padding(.trailing, .spacer8)
                    
                Spacer()
            }
            .accessibilityElement()
            .accessibilityLabel("List item. Pokemon: \(pokemonName)")
            .padding(.leading, 10)
            .frame(maxWidth: .infinity, maxHeight: 100)
            .navigationTitle("Pokemons!")
            .background {
                if isSelected {
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(Color.listSelectionColour)
                        .padding(4)
                } else { Color.clear }
            }
            .task {
                do {
                    let pokemon = try await pokemonService.pokemon(named: pokemonName)
                    state = .downloaded(pokemon)
                } catch {
                    state = .error
                }
            }
        }
    }
}
