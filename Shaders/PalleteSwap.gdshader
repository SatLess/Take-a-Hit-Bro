shader_type canvas_item;

uniform sampler2D pallete[3];
uniform float swapper = 0.0;
uniform int idx = 0;
uniform vec4 result;

void fragment() {
	if(true){
		vec4 rbga = texture(TEXTURE,UV);
		vec4 final_color = texture(pallete[idx],vec2(rbga.r,rbga.g));
		final_color.a = rbga.a;
		COLOR = mix(rbga,final_color,clamp(swapper, 0.0, 1.5));
	}
}

