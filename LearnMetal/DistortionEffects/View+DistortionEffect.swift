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
    
    func wigglyShader() -> some View {
        modifier(WigglyShader())
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

struct WigglyShader: ViewModifier {

    private let startDate = Date()

    func body(content: Content) -> some View {
        TimelineView(.animation) { _ in
            content
                .padding(.vertical, 50)
                .drawingGroup()
                .distortionEffect(
                    ShaderLibrary.wiggly(
                        .float(startDate.timeIntervalSinceNow)),
                    maxSampleOffset: CGSize(width: 0, height: 50)
                )
        }
    }
}
