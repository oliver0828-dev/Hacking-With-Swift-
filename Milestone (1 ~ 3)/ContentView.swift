//
//  ContentView.swift
//  Project 3
//
//  Created by Oliver Park on 4/2/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
           Text("Good, Morning")
            .giantBlueTitleStyle()
                
    }
}

#Preview {
    ContentView()
}

struct giantBlueTitle: ViewModifier{
    func body(content: Content) -> some View { content
        .font(.largeTitle)
        .fontWeight(.bold)
        .foregroundStyle(.blue)
        
    }
}

extension View{
    func giantBlueTitleStyle() -> some View{
        modifier(giantBlueTitle())
    }
}
