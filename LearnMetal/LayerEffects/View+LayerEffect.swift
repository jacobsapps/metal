//
//  View+LayerEffect.swift
//  LearnMetal
//
//  Created by Jacob Bartlett on 06/11/2023.
//

import SwiftUI

extension View {
    
    func pixellationShader(pixelSize: Float = 8) -> some View {
        modifier(PixellationShader(pixelSize: pixelSize))
    }
}

struct PixellationShader: ViewModifier {
    
    let pixelSize: Float
    let startDate = Date()
    
    func body(content: Content) -> some View {
        TimelineView(.animation) { _ in
            content
                .layerEffect(
                    ShaderLibrary.pixellate(
                        .float(pixelSize),
                        .float(startDate.timeIntervalSinceNow)
                    ), maxSampleOffset: .zero
                )
        }
    }
}
