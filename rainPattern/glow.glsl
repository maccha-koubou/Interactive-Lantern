uniform sampler2D texture;
uniform vec2 resolution;
uniform float glowRadius = 10.0;

void main() {
    vec2 uv = gl_FragCoord.xy / resolution;
    vec4 originalColor = vec4(texture2D(texture, uv).rgb, 1.0);
    
    // Calculate the average color around the pixel
    vec3 color = vec3(0.0);
    float total = 0.0;
    for (float x = -glowRadius; x <= glowRadius; x++) {
        for (float y = -glowRadius; y <= glowRadius; y++) {
            vec2 offset = vec2(x, y) / resolution;
            color += texture2D(texture, uv + offset).rgb;
            total += 1.0;
        }
    }
    color /= total;
    
    vec4 glowColor = vec4(color, 1.0);
    gl_FragColor = originalColor + glowColor;
}