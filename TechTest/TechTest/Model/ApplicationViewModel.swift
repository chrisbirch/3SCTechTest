import SwiftUI

class ApplicationViewModel: ObservableObject {
 
    @Published var naviagtionPath = [PokemonUIItem]()
    
    var selectedPokemon: PokemonUIItem? {
        naviagtionPath.last
    }
}
