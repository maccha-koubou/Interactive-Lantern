uniform sampler2D texture;
uniform vec2 resolution;//屏幕分辨率
uniform float glowRadius = 10.0;//发光半径

void main() {
    vec2 uv = gl_FragCoord.xy / resolution;//获取当前像素的屏幕坐标
    vec4 originalColor = vec4(texture2D(texture, uv).rgb, 1.0);//获取当前像素的原始颜色，alpha设为不透明
    
    //计算周围像素的颜色平均值
    vec3 color = vec3(0.0);//新建黑色的颜色向量
    float total = 0.0;
    for (float x = -glowRadius; x <= glowRadius; x++) {//遍历以glowRadius为半径的方形区域
        for (float y = -glowRadius; y <= glowRadius; y++) {
            vec2 offset = vec2(x, y) / resolution;//计算当前所遍历像素的位置
            color += texture2D(texture, uv + offset).rgb;//累加所有遍历到的像素的rgb
            total += 1.0;
        }
    }
    color /= total;//取平均色
    
    vec4 glowColor = vec4(color, 1.0);//发光效果
    gl_FragColor = originalColor + glowColor;//原图案和发光效果累加
}