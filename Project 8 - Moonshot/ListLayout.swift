//
//  ListLayout.swift
//  Moonshot
//
//  Created by Oliver Park on 4/27/24.
//

import SwiftUI

struct ListLayout: View {
    let astronauts: [String : Astronaut]
    let missions: [Mission]
    
    var body: some View {
        NavigationStack {
            List(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronaut: astronauts)
                } label : {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                        VStack{
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)
                            
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                    }
                }
            }
            .listRowBackground(Color.darkBackground)
        }
        .listStyle(.plain)
    }
}

#Preview {
    let astronaut : [String : Astronaut] = Bundle.main.decode("astronauts.json")
    let mission: [Mission] = Bundle.main.decode("missions.json")
    return ListLayout(astronauts: astronaut, missions: mission)
        .preferredColorScheme(.dark)
}
