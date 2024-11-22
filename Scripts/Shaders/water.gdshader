shader_type spatial;

uniform sampler2D watertexture : repeat_enable;
uniform sampler2D colorramp : repeat_disable;
uniform sampler2D highlight_ramp : repeat_disable;
uniform float highlight_intensity : hint_range(0,1);
uniform vec2 direction_1 = vec2(-0.12,0.07);
uniform vec2 direction_2 = vec2(-0.13,-0.06);
uniform vec2 direction_3 = vec2(-0.08,0.0);
uniform vec2 direction_4 = vec2(-0.4,0.16);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec2 thecolor = (texture(watertexture, UV*12.3+TIME*direction_1).rg*texture(watertexture, UV*16.1+TIME*direction_2).rg*texture(watertexture, UV*6.1+TIME*direction_3).rg*texture(watertexture, UV*20.3+TIME*direction_4).rg);
	vec3 highlights = texture(highlight_ramp, thecolor).rgb;

	thecolor += exp2(texture(watertexture, UV*0.7+TIME*direction_3*0.2).rg);
	thecolor = clamp(thecolor*0.55f-0.5f, vec2(0), vec2(1));
	ALBEDO = texture(colorramp, thecolor).rgb+(highlights*highlight_intensity);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
