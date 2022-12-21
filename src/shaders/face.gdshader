shader_type spatial;
render_mode unshaded, shadows_disabled, cull_disabled;

uniform sampler2D albedo_texture : hint_albedo;

void fragment() {
	vec4 color = texture(albedo_texture, UV);
	ALBEDO = color.rgb;
	ALPHA = color.a;
}
