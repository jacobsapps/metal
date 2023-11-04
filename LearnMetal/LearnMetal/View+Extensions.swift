//
//  View+Extensions.swift
//  LearnMetal
//
//  Created by Jacob Bartlett on 26/10/2023.
//

import SwiftUI

extension View {
    
    func colorShader() -> some View {
        modifier(ColorShader())
    }
    
    func visualEffectShader() -> some View {
        modifier(VisualEffectShader())
    }
    
    func timeVaryingShader() -> some View {
        modifier(TimeVaryingShader())
    }
    
    func angleAwareShader(angle: Angle) -> some View {
        modifier(AngleAwareShader(angle: angle))
    }
    
    func checkboxShader() -> some View {
        modifier(CheckboxShader())
    }
    
    func distortionShader() -> some View {
        modifier(DistortionShader())
    }
    
    func distortionTimeShader() -> some View {
        modifier(DistortionTimeShader())
    }
    
    func layerEffectShader(pixelSize: Float) -> some View {
        modifier(LayerEffectShader(pixelSize: pixelSize))
    }
    
    func randomNoiseShader() -> some View {
        modifier(RandomNoiseShader())
    }
    
    func perlinNoiseShader() -> some View {
        modifier(PerlinNoiseShader())
    }
    
    func perlinNoiseTimeShader() -> some View {
        modifier(PerlinNoiseTimeShader())
    }
}

struct ColorShader: ViewModifier {
    
    func body(content: Content) -> some View {
        content.visualEffect { content, geometryProxy in
            content.colorEffect(
                ShaderLibrary.color_shader()
            )
        }
    }
}

// MARK: - VisualEffect

struct VisualEffectShader: ViewModifier {
    
    func body(content: Content) -> some View {
        content.visualEffect { content, proxy in
            content
                .colorEffect(
                    ShaderLibrary.visual_effect_shader(
                        .float2(proxy.size)
                    )
                )
        }
    }
}

// MARK: - TimelineView

struct TimeVaryingShader: ViewModifier {
    
    let startDate = Date()
    
    func body(content: Content) -> some View {
        TimelineView(.animation) { _ in
            content.visualEffect { content, proxy in
                content
                    .colorEffect(
                        ShaderLibrary.time_varying_shader(
                            .float2(proxy.size),
                            .float(startDate.timeIntervalSinceNow)
                        )
                    )
            }
        }
    }
}

struct AngleAwareShader: ViewModifier {
    
    let angle: Angle
    let startDate = Date()
    
    func body(content: Content) -> some View {
        TimelineView(.animation) { _ in
            content.visualEffect { content, proxy in
                content
                    .colorEffect(
                        ShaderLibrary.angle_aware_shader(
                            .float2(proxy.size),
                            .float(startDate.timeIntervalSinceNow),
                            .float(angle.radians)
                        )
                    )
            }
        }
    }
}

struct CheckboxShader: ViewModifier {
    
    func body(content: Content) -> some View {
        content.visualEffect { content, proxy in
            content
                .colorEffect(
                    ShaderLibrary.checkbox_shader(
                        .float2(proxy.size)
                    )
                )
        }
    }
}

struct DistortionShader: ViewModifier {

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 100)
            .drawingGroup()
            .distortionEffect(
                ShaderLibrary.distortion_shader(),
                maxSampleOffset: CGSize(width: 100, height: 0)
            )
    }
}

struct DistortionTimeShader: ViewModifier {

    let startDate = Date()

    func body(content: Content) -> some View {
        TimelineView(.animation) { _ in
            content
                .padding(100)
                .background(Color.white.opacity(0.0001))
                .distortionEffect(
                    ShaderLibrary.distortion_time_shader(
                        .float(startDate.timeIntervalSinceNow)),
                    maxSampleOffset: CGSize(width: 100, height: 100)
                )
        }
    }
}

struct EmbossShader: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.linearGradient(colors: [.orange, .red], startPoint: .top, endPoint: .bottom))
            .layerEffect(
                ShaderLibrary.emboss_shader(
                    .float(100.0)
                ), maxSampleOffset: .zero
            )
    }
}

struct LayerEffectShader: ViewModifier {
    
    let pixelSize: Float
    let startDate = Date()
    
    func body(content: Content) -> some View {
        TimelineView(.animation) { _ in
            content
                .layerEffect(
                    ShaderLibrary.layer_effect_shader(
                        .float(pixelSize),
                        .float(startDate.timeIntervalSinceNow)
                    ), maxSampleOffset: .zero
                )
        }
    }
}

struct RandomNoiseShader: ViewModifier {
    
    let startDate = Date()
    
    func body(content: Content) -> some View {
        TimelineView(.animation) { _ in
            content
                .colorEffect(
                    ShaderLibrary.random_noise_shader(
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
                    ShaderLibrary.perlin_noise_shader(
                        .float2(proxy.size)
                    )
                )
        }
    }
}

struct PerlinNoiseTimeShader: ViewModifier {
    
    let startDate = Date()
    
    func body(content: Content) -> some View {
        TimelineView(.animation) { _ in
            content.visualEffect { content, proxy in
                content
                    .colorEffect(
                        ShaderLibrary.perlin_noise_time_shader(
                            .float2(proxy.size),
                            .float(startDate.timeIntervalSinceNow)
                        )
                    )
            }
        }
    }
}


/*

 extension View {
     
     func shader(_ shader: Shader) -> some View {
         modifier(shader.viewModifier)
     }
 }

 enum Shader {
     
     case color
     case visualEffect
     case timeVarying
     case checkbox
     case distortion
     case randomNoise
     case perlinNoise
     
     var viewModifier: any ViewModifier {
         switch self {
         case .color: return ColorShader()
         case .visualEffect: return VisualEffectShader()
         case .timeVarying: return TimeVaryingShader()
         case .checkbox: return CheckboxShader()
         case .distortion: return DistortionShader()
         case .randomNoise: return RandomNoiseShader()
         case .perlinNoise: return PerlinNoiseShader()
         }
     }
 }
 
 */
