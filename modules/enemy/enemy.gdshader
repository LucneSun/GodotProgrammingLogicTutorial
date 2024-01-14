shader_type spatial;

void vertex() {
	VERTEX *= vec3(abs(sin(VERTEX.x + TIME * 2.0)), abs(sin(VERTEX.x + TIME * 2.0)) ,abs(sin(VERTEX.x + TIME * 2.0)));
}

void fragment() {
	ALBEDO = NORMAL.xyz;
	ROUGHNESS = 0.2;
	METALLIC = 1.0;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
