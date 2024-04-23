import SwiftUI

/// View used for both iPhone and iPad to display Stats for the selected pokemon
struct PokemonStatsView: View {
    @Binding var pokemon: Pokemon
    
    private func labelValueView(label: String, value: String) -> some View {
        VStack(alignment: .center) {
            HStack {
                Spacer()
                Text(label)
                    .font(.caption)
                    .bold()
                Spacer()
            }
            HStack {
                Spacer()
                Text(value)
                    
                Spacer()
            }
            
        }
        .padding(.horizontal, .spacer4)
        .padding(.vertical, .spacer2)
        .background(Color.white.opacity(0.1))
        .cornerRadius(.spacer8)
        .border(.black.opacity(0.1), width: 1)
    }
    var body: some View {
        VStack {
            HStack {
                Text("Stats")
                    .font(.headline)
                Spacer()
            }.padding(.horizontal, .spacer16)

            ScrollView(.horizontal) {
                
                HStack {
                    ForEach(pokemon.stats) { stat in
                        VStack(alignment: .center, spacing: .spacer4) {
                            labelValueView(label: "Name", value: stat.name)
                            labelValueView(label: "Effort", value: String(describing: stat.effort))
                            labelValueView(label: "Base Stat", value: String(describing: stat.baseStat))
                        }
                        .padding(.spacer8)
                        .background {
                            Color.statBackgroundColour
                        }.cornerRadius(.spacer8)
                    }
                }.padding()
            }
        }
    }
}
