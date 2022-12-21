extends Spatial

var OffMaterial = SpatialMaterial.new()
var OnMaterial = SpatialMaterial.new()

func _ready() -> void:
	OnMaterial.albedo_color = Color.yellow
	OnMaterial.emission_enabled = true
	OnMaterial.emission = Color.yellow
	OffMaterial.albedo_color = Color.orange
	_set_material(OffMaterial)

func set_alarm(p_alarm: bool) -> void:
	var next_material = OnMaterial if p_alarm else OffMaterial
	_set_material(next_material)

func _set_material(p_material: Material) -> void:
	$AlarmLampMesh.material_override = p_material
