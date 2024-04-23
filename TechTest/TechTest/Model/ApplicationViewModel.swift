import SwiftUI

class ApplicationViewModel: ObservableObject {
 
    @Published var naviagtionPath = [String]()
    
    var selectedPokemonName: String? {
        naviagtionPath.last
    }
}
