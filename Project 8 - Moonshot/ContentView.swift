//
//  ContentView.swift
//  Moonshot
//
//  Created by Oliver Park on 4/17/24.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String : Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showingGrid: Bool = true
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
                Group {
                    if showingGrid {
                        GridLayout(astronauts: astronauts, missions: missions)
                    } else {
                        ListLayout(astronauts: astronauts, missions: missions)
                    }
            }
                .toolbar {
                    Button {
                        showingGrid.toggle()
                    } label: {
                        if showingGrid {
                            Label("List View", systemImage: "list.bullet")
                        } else {
                            Label("Grid View", systemImage: "square.grid.3x2")
                        }
                    }
                }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
           
        }
        
        
    }
}

#Preview {
    ContentView()
}
