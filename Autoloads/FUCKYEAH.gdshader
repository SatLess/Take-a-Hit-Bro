shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, repeat_disable,filter_nearest;

void fragment() {
	COLOR = textureLod(screen_texture,,0.0);// Called for every pixel the material is visible on.
}

