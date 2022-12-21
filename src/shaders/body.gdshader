shader_type spatial;
render_mode diffuse_toon, specular_disabled;

uniform sampler2D albedo_texture : hint_albedo;
uniform sampler2D albedo_curve : hint_albedo;

void fragment() {
	ALBEDO = texture(albedo_texture, UV).rgb;
}

void light() {
	vec3 litness = texture(albedo_curve, vec2(dot(LIGHT, NORMAL), 0.0)).rgb;
	vec3 diffuse_color = 0.3 * ALBEDO * litness;
	DIFFUSE_LIGHT = max(DIFFUSE_LIGHT, diffuse_color);
}
