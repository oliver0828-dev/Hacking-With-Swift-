//
//  MissionHorizontalScrollView.swift
//  Moonshot
//
//  Created by Oliver Park on 4/27/24.
//

import SwiftUI

struct MissionHorizontalScrollView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let crew: [CrewMember]
    
    var body: some View {
        NavigationStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(crew, id: \.role) { crewMember in
                        NavigationLink {
                            AstronautView(astronaut: crewMember.astronaut)
                        } label: {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 104, height: 72)
                                    .clipShape(.capsule)
                                    .overlay(
                                        Capsule()
                                            .strokeBorder(.white, lineWidth: 1)
                                    )
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .foregroundStyle(.white)
                                        .font(.headline)
                                    
                                    Text(crewMember.role)
                                        .foregroundStyle(.white.opacity(0.4))
                                    
                                }
                            }
                        }
                        
                    }
                }
                
            }
        }
        .padding(.bottom)
    }
    init (mission: Mission, astronaut: [String : Astronaut]){
        self.mission = mission
        
        self.crew = mission.crew.map { member in
            if let astronaut = astronaut[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
            }
            
        }
    }
}



#Preview {
    let mission: [Mission] = Bundle.main.decode("mission.json")
    let astronauts: [String : Astronaut] = Bundle.main.decode("astronauts.json")
    return MissionHorizontalScrollView(mission: mission[0], astronaut: astronauts)
        .preferredColorScheme(.dark)
}
