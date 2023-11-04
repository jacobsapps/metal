//
//  ContentView.swift
//  LearnMetal
//
//  Created by Jacob Bartlett on 26/10/2023.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack {
//            Color.white
//                .edgesIgnoringSafeArea(.all)
//                .perlinNoiseShader()
        
            Image(systemName: "globe")
                .font(.system(size: 200))
                .layerEffectShader(pixelSize: 10)
            
//            Text("Hello, world!")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .kerning(2)
//                .foregroundStyle(.green)
//                .distortionTimeShader()
        }
    }
}

#Preview {
    ContentView()
}
