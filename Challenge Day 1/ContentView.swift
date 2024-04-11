//
//  ContentView.swift
//  Rock, Paper, Scissors
//
//  Created by Oliver Park on 4/6/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var score: Int = 0
    @State private var round: Int = 1
    
    let rpsArr: [String] = ["Rock", "Scissors", "Paper"]
    var airpsArr: [String] {
        get {
            ["Rock", "Scissors", "Paper"].shuffled()
        }
    }
   
    var body: some View {
        NavigationStack{
            ZStack{
                Color.blue
                    .blur(radius: 300)
                    .ignoresSafeArea()
                VStack{
                    Text("Round \(round)")
                        .font(.largeTitle)
                        .fontWeight(.light)
                    scoreDisplayView(score: score)
                    HStack{
                        ForEach(0..<3) { button in
                            ZStack{
                                RoundedRectangle(cornerRadius: 20.0)
                                    .fill(.white)
                                    .opacity(0.25)
                                    .shadow(radius: 20.0)
                                    .frame(width: 120, height: 40)
                                Button(action: {
                                    print("\(rpsArr[button]) was tapped")
                                    round += 1
                                    rps(Choice: rpsArr[button], AIChoice: airpsArr[button])
                                    if round == 10 {
                                        if score <= 5 {
                                            alertMessage = "Better luck next time! Your score: \(score)/10"
                                            score = 0
                                            round = 1
                                        } else {
                                            alertMessage = "Great job! Your score: \(score)/10"
                                            score = 0
                                            round = 1
                                        }
                                        showAlert = true
                                    }
                                    UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
                                }, label: {
                                    Text("\(rpsArr[button])")
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.black)
                                })
                                .alert(isPresented: $showAlert) {
                                    Alert(title: Text("Game Over"), message: Text(alertMessage), dismissButton: .destructive(Text("RESET")) {
                                    })
                                }
                            }
                        }
                    }
                    
                }
                
            }
            Spacer(minLength: 100)
            .navigationTitle("RPS")
        }
    }
    func rps(Choice: String, AIChoice: String) {
        if (Choice == "Rock" && AIChoice == "Scissors") ||
            (Choice == "Scissors" && AIChoice == "Paper") ||
            (Choice == "Paper" && AIChoice == "Rock") {
      
            score += 1
        } else if Choice == AIChoice {
            score += 0
        } else {
            score += 0
        }
        print("AI chose \(AIChoice)")
    }
}

#Preview {
    ContentView()
}

struct scoreDisplayView: View{
    var score: Int
    var body: some View{
        VStack{
            VStack{
                ZStack{
                    RoundedRectangle(cornerRadius: 20.0)
                        .fill(.white)
                        .opacity(0.25)
                        .shadow(radius: 20.0)
                        .frame(width: 300, height: 300)
                        .padding()
                    VStack{
                        Text("SCORE")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                        Text("\(score)")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                            .padding()
                    }
                }
            }
        }
    }
}




