extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var WoodCuttersHut: PackedScene = ResourceLoader.load("res://Assets/WoodCutters.tscn")
var StoneCuttersHut: PackedScene = ResourceLoader.load("res://Assets/StoneMasons.tscn")
var Granary: PackedScene = ResourceLoader.load("res://Assets/Granary.tscn")
var Stockpile: PackedScene = ResourceLoader.load("res://Assets/Stockpile.tscn")
var House: PackedScene = ResourceLoader.load("res://Assets/House.tscn")
var Wall: PackedScene = ResourceLoader.load("res://Assets/wallNarrow.tscn")
var CornerWall: PackedScene = ResourceLoader.load("res://Assets/wallNarrowCorner.tscn")
var Orchard: PackedScene = ResourceLoader.load("res://Assets/Orchard.tscn")
var AbleToBuild : bool = true
var CurrentSpawnable : StaticBody
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GameManager.CurrentState == GameManager.State.Build:
		var camera = get_viewport().get_camera()
		var from = camera.project_ray_origin(get_viewport().get_mouse_position())
		var to = from + camera.project_ray_normal(get_viewport().get_mouse_position()) * 1000
		var cursorPos = Plane(Vector3.UP, transform.origin.y).intersects_ray(from, to)
		CurrentSpawnable.translation = Vector3(round(cursorPos.x), cursorPos.y, round(cursorPos.z))
		CurrentSpawnable.ActiveBuildableObject = true
		if AbleToBuild:
			if Input.is_action_just_released("LeftMouseButton"):
				var obj := CurrentSpawnable.duplicate()
				get_tree().root.add_child(obj)
				obj.ActiveBuildableObject = false
				obj.translation = CurrentSpawnable.translation
	pass

func SpawnWoodcutter():
	SpawnObj(WoodCuttersHut)
	
func SpawnStoneCutter():
	SpawnObj(StoneCuttersHut)

func SpawnObj(obj):
	if CurrentSpawnable != null:
		CurrentSpawnable.queue_free()
	CurrentSpawnable = obj.instance()
	get_tree().root.add_child(CurrentSpawnable)
	GameManager.CurrentState = GameManager.State.Build
	
