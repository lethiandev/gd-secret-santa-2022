shader_type spatial;
render_mode diffuse_toon, specular_disabled, depth_draw_alpha_prepass, cull_disabled;

uniform sampler2D albedo_texture : hint_albedo;
uniform sampler2D albedo_curve : hint_albedo;

void fragment() {
	vec4 color = texture(albedo_texture, UV);
	ALBEDO = color.rgb;
	ALPHA = color.a;
}

void light() {
	vec3 litness = texture(albedo_curve, vec2(dot(LIGHT, NORMAL), 0.0)).rgb;
	vec3 diffuse_color = 0.3 * ALBEDO * litness;
	DIFFUSE_LIGHT = max(DIFFUSE_LIGHT, diffuse_color);
}
