shader_type canvas_item;

uniform bool can_swap = false;
uniform sampler2D palletes[4];
uniform int pallete_idx = 0;

void fragment() {
	vec4  textube = texture(TEXTURE, UV); // gets 'texels' aka texture pixels at the coordinate on UV
	//float palette_swap = mod(textube.r - TIME* .1, 1.0); //modulo operator but it does it do something?
	float grayscale = textube.r * 0.299 + textube.g * 0.587 + textube.b * 0.114;  // formula for grey conversion
	textube.rgb = vec3(grayscale);
	
	vec4 final_color = texture(palletes[pallete_idx],vec2(textube.r));
	final_color.a = textube.a;
	//final_color.a = textube.a;
	//textube = vec4(texture(palletes[pallete_idx], vec2(palette_swap, 0)).rgb, textube.a);
	COLOR = final_color;

}

