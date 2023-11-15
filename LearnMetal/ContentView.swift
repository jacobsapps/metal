//
//  ContentView.swift
//  LearnMetal
//
//  Created by Jacob Bartlett on 26/10/2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Text("Hello, world!")
            .font(.largeTitle)
            .fontWeight(.bold)
            .kerning(2)
            .foregroundStyle(.green)
            .wigglyShader()
    }
}

#Preview {
    ContentView()
}
