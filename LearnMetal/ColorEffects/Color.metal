//
//  Color.metal
//  LearnMetal
//
//  Created by Jacob Bartlett on 06/11/2023.
//

#include <metal_stdlib>
using namespace metal;

[[ stitchable ]]
half4 color(
    float2 position,
    half4 color
) {
    return half4(128.0/255.0, 128.0/255.0, 128.0/255.0, 1.0);
}
