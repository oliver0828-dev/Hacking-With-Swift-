//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Oliver Park on 3/23/24.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var selectedFlag = -1
    @State private var n = 0
    
    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)],
                           center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack{
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button{
                            flagTapped(number)
                            n += number
                        } label: {
                            FlagImage(country: countries[number])
                                .rotation3DEffect(.degrees(selectedFlag == number ? 360 : 0), axis: (x: 0.0, y: 1.0, z: 0.0))
                                .animation(.default, value: selectedFlag)
                                .opacity(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0.25)
                                .scaleEffect(selectedFlag == -1 || selectedFlag == number ? 1.0 : 0.5)
                            
                        }
                    }
                }
                .frame(maxWidth:.infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .frame(width: 120, height: 50)
                    .background(.blue.gradient)
                    .clipShape(.rect(cornerRadius: 10))
                    .foregroundStyle(.white)
                    .font(.title.bold())
                    
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            if score > 0 {
                score -= 1
            }
        }
        
        showingScore = true
        selectedFlag = number
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        selectedFlag = -1
    }
}

#Preview {
    ContentView()
}

struct FlagImage: View {
    var country: String
    var body: some View {
        Image(country)
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}
