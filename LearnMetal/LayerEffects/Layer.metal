//
//  Layer.metal
//  LearnMetal
//
//  Created by Jacob Bartlett on 06/11/2023.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[ stitchable ]]
half4 pixellate(float2 position, SwiftUI::Layer layer) {
    return layer.sample(position);
}
