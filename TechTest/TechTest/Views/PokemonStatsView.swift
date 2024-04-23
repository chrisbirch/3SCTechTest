import SwiftUI

struct PokemonStatsView: View {
    @Binding var pokemon: Pokemon
    
    private func labelValueView(label: String, value: String) -> some View {
        HStack {
            Text(("\(label):"))
            Text(value)
        }
    }
    var body: some View {
        VStack {
            Text("Stats:")
            ScrollView(.horizontal) {
                
                HStack {
                    ForEach(pokemon.stats) { stat in
                        VStack {
                            labelValueView(label: "Name", value: stat.name)
                            labelValueView(label: "Effort", value: String(describing: stat.effort))
                            labelValueView(label: "Base Stat", value: String(describing: stat.baseStat))
                        }
                        .padding(10)
                        .background {
                            Color.green
                        }
                    }
                }.padding()
            }
        }
    }
}
