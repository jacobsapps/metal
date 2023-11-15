//
//  View+ExtraEffects.swift
//  LearnMetal
//
//  Created by Jacob Bartlett on 06/11/2023.
//

import SwiftUI

extension View {

    func randomNoiseShader() -> some View {
        modifier(RandomNoiseShader())
    }
    
    func perlinNoiseShader() -> some View {
        modifier(PerlinNoiseShader())
    }
}

struct RandomNoiseShader: ViewModifier {
    
    let startDate = Date()
    
    func body(content: Content) -> some View {
        TimelineView(.animation) { _ in
            content
                .colorEffect(
                    ShaderLibrary.randomNoise(
                        .float(startDate.timeIntervalSinceNow)
                    )
                )
        }
    }
}

struct PerlinNoiseShader: ViewModifier {
    
    func body(content: Content) -> some View {
        content.visualEffect { content, proxy in
            content
                .colorEffect(
                    ShaderLibrary.perlinNoise(
                        .float2(proxy.size)
                    )
                )
        }
    }
}
