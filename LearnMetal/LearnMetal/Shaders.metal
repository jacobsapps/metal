//
//  Shaders.metal
//  LearnMetal
//
//  Created by Jacob Bartlett on 26/10/2023.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;

[[ stitchable ]] 
half4 color_shader(
    float2 position,
    half4 color
) {
    return half4(position.x/255.0, position.y/255.0, 0.0, 1.0);
}

[[ stitchable ]]
half4 visual_effect_shader(
    float2 position,
    half4 color,
    float2 size
) {
    return half4(position.x/size.x, position.y/size.y, position.x/size.y, 1.0);
}

float positive_sin(float t) {
    return 0.5 * (sin(t) + 1);
}

float cos_oscillator(float t) {
    return 0.5 * (cos(t) + 1);
}

[[ stitchable ]]
half4 time_varying_shader(
    float2 position,
    half4 color,
    float2 size,
    float time
) {
    float t = 2 * time;
    return half4(positive_sin(t + (2 * position.x / size.x)),
                 positive_sin(M_PI_F + (2 * t) + (2 * position.y / size.y)),
                 positive_sin(-t + (2 * position.x / size.y)),
                 1.0);
}

[[ stitchable ]]
half4 angle_aware_shader(
    float2 position,
    half4 color,
    float2 size,
    float time,
    float angle
) {
    float t = 2 * time;
    return half4(positive_sin(angle + t + (2 * position.x / size.x)),
                 positive_sin(angle + M_PI_F + (2 * t) + (2 * position.y / size.y)),
                 positive_sin(angle + -t + (2 * position.x / size.y)),
                 1.0);
}

[[ stitchable ]]
half4 checkbox_shader(
    float2 position,
    half4 color,
    float2 size
) {
    uint2 posInChecks = uint2(position.x / 10, position.y / 10);
    bool isColor = (posInChecks.x ^ posInChecks.y) & 1;
    return isColor ? color : half4(0, 0, 0, 1);
}

[[ stitchable ]] 
float2 distortion_shader(
    float2 position
) {
    
    // Shift image
    return float2(position.x + 100, position.y);
//    return float2(position.x * 2, position.y);
    
}

[[ stitchable ]]
float2 distortion_time_shader(
    float2 position,
    float time
) {
    
    // Build up wiggly text
//    return position;
//    return float2(position.x, position.y + 20 * (sin(time)));
//    return float2(position.x, position.y + 20 * (sin(time + position.x)));
    return float2(position.x, position.y + 3 * (sin(2 * time + (position.x / 10))));
}

[[ stitchable ]] 
half4 layer_effect_shader(
    float2 position,
    SwiftUI::Layer layer,
    float size,
    float time
) {
    float sample_x = sin(time) + size * round(position.x / size);
    float sample_y = cos(time) + size * round(position.y / size);
    return layer.sample(float2(sample_x, sample_y));
}

[[ stitchable ]] 
half4 random_noise_shader(
    float2 position,
    half4 color,
    float time
) {
    float value = fract(sin(dot(position + time, float2(12.9898, 78.233))) * 43758.5453);
    return half4(value, value, value, 1) * color.a;
}

float random(float2 position) {
    return fract(sin(dot(position, float2(12.9898, 78.233)))
                     * 43758.5453123);
}

float noise(float2 st) {

    float2 i = floor(st);
    float2 f = fract(st);

    float a = random(i);
    float b = random(i + float2(1.0, 0.0));
    float c = random(i + float2(0.0, 1.0));
    float d = random(i + float2(1.0, 1.0));

    float2 u = f*f*(3.0-2.0*f);

    return mix(a, b, u.x) 
        + (c - a) * u.y * (1.0 - u.x)
        + (d - b) * u.x * u.y;
}

[[ stitchable ]]
half4 perlin_noise_shader(
    float2 position,
    half4 color,
    float2 size
) {
    float2 st = position / size;
    float2 pos = float2(st * 10);
    float n = noise(pos);
    return half4(half3(n), 1.0);
}

float random_time(float2 position, float time) {
    position += time;
    return fract(sin(dot(position.xy, float2(12.9898, 78.233)) + position.y * (sin(time))) * 43758.5453123);
}

float noise_time(float2 st, float time) {

    float2 i = floor(st);
    float2 f = fract(st);

    float a = random_time(i, time);
    float b = random_time(i + float2(1.0, 0.0), time);
    float c = random_time(i + float2(0.0, 1.0), time);
    float d = random_time(i + float2(1.0, 1.0), time);

    float2 u = smoothstep(0.,1.,f);

    return mix(a, b, u.x)
        + (c - a) * u.y * (1.0 - u.x)
        + (d - b) * u.x * u.y;
}

[[ stitchable ]]
half4 perlin_noise_time_shader(
    float2 position,
    half4 color,
    float2 size,
    float time
) {
    float2 st = position / size;
    float2 pos = float2(st * 15);
    float n = noise_time(pos, time);
    return half4(half3(n), 1.0);
}
