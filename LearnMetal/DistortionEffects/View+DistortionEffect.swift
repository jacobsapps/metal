//
//  View+DistortionEffect.swift
//  LearnMetal
//
//  Created by Jacob Bartlett on 06/11/2023.
//

import SwiftUI

extension View {
    
    func distortionShader() -> some View {
        modifier(DistortionShader())
    }
}

struct DistortionShader: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 100)
            .drawingGroup()
            .distortionEffect(
                ShaderLibrary.distortion(),
                maxSampleOffset: CGSize(width: 100, height: 0)
            )
    }
}
