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
		if AbleToBuild && canAfford(CurrentSpawnable):
			if Input.is_action_just_released("LeftMouseButton"):
				var obj := CurrentSpawnable.duplicate()
				get_tree().root.add_child(obj)
				obj.ActiveBuildableObject = false
				obj.runSpawn()
				obj.spawned = true
				ChargeObject(obj)
				obj.SetDisabled(false)
				obj.translation = CurrentSpawnable.translation
	pass

func canAfford(obj) -> bool:
	if GameManager.Wood - obj.WoodCost < 0:
		return false
	if GameManager.Stone - obj.StoneCost < 0:
		return false
	if GameManager.Gold - obj.GoldCost < 0:
		return false
	if GameManager.Iron - obj.IronCost < 0:
		return false
	return true
	
func ChargeObject(obj):
	GameManager.Wood -= obj.WoodCost
	GameManager.Stone -= obj.StoneCost
	GameManager.Gold -= obj.GoldCost
	GameManager.Iron -= obj.IronCost
	
	
func SpawnWoodcutter():
	SpawnObj(WoodCuttersHut)
	
func SpawnStoneCutter():
	SpawnObj(StoneCuttersHut)
	
func SpawnStockPile():
	SpawnObj(Stockpile)

func SpawnObj(obj):
	if CurrentSpawnable != null:
		CurrentSpawnable.queue_free()
	CurrentSpawnable = obj.instance()
	if CurrentSpawnable == null:
		print("Current Spawn is null!!")
	CurrentSpawnable.SetDisabled(true)
	get_tree().root.add_child(CurrentSpawnable)
	GameManager.CurrentState = GameManager.State.Build
	
