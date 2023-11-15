//
//  View+LayerEffect.swift
//  LearnMetal
//
//  Created by Jacob Bartlett on 06/11/2023.
//

import SwiftUI

extension View {
    
    func pixellationShader() -> some View {
        modifier(PixellationShader())
    }
}

struct PixellationShader: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .layerEffect(
                ShaderLibrary.pixellate(),
                maxSampleOffset: .zero
            )
    }
}
