shader_type canvas_item;

void fragment() {
	vec2 uv = UV;
	float edge = smoothstep(0.0, 0.1, uv.x) *
	             smoothstep(0.0, 0.1, uv.y) *
	             smoothstep(1.0, 0.9, uv.x) *
	             smoothstep(1.0, 0.9, uv.y);

	COLOR = texture(TEXTURE, uv);
	COLOR.a *= edge;
}