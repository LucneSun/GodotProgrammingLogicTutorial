shader_type spatial;
uniform sampler2D color;
void vertex() {
	vec4 tex = texture(color, UV + vec2(abs(0.03 * TIME), abs(0.03 * TIME)));
	VERTEX += vec3( 0, tex.a * 1.0, 0);
}

void fragment() {
	EMISSION = texture(color, UV + vec2(abs(0.03 * TIME), abs(0.03 * TIME))).rgb;
	ALPHA = texture(color, UV + vec2(abs(0.03 * TIME), abs(0.03 * TIME))).a;
	ROUGHNESS = 0.0;
	METALLIC = 0.0;
	
}


