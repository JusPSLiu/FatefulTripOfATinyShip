shader_type spatial;

uniform sampler2D watertexture : repeat_enable;
uniform sampler2D colorramp : repeat_disable;
uniform vec2 direction_1 = vec2(-0.05,0.014);
uniform vec2 direction_2 = vec2(-0.06,-0.03);
uniform vec2 direction_3 = vec2(-0.04,0.0);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 thecolor = (texture(watertexture, UV*12.3+TIME*direction_1).rg*texture(watertexture, UV*16.1+TIME*direction_2).rg*texture(watertexture, UV*6.1+TIME*direction_3).rg+exp2(texture(watertexture, UV*0.7+TIME*direction_3*0.5).rg));
	thecolor = clamp(thecolor*0.5f-0.5f, vec2(0), vec2(1));
	ALBEDO = texture(colorramp, thecolor).rgb;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
