shader_type canvas_item;

void fragment() {
	vec2 uv = UV;
	uv += TIME * 0.5;
	vec4 col = texture(TEXTURE, uv);
	col.a *= 0.10;
	COLOR = col;
}
