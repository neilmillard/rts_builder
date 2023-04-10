extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var objects : Array
var ActiveBuildableObject : bool

export var SpawnActor : bool = true
export var Actor : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area.connect("area_entered", self, "_on_Area_area_entered")
	$Area.connect("area_exited", self, "_on_Area_area_exited")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func runSpawn():
	if SpawnActor:
		var actor = Actor.instance()
		get_tree().root.add_child(actor)
		actor.global_translation = $SpawnPoint.global_translation
		actor.Hut = $SpawnPoint.global_translation

func _on_Area_area_entered(area):
	if ActiveBuildableObject:
		objects.append(area)
		BuildManager.AbleToBuild = false
	
func _on_Area_area_exited(area):
	if ActiveBuildableObject:
		objects.remove(objects.find(area))
		if(objects.size() <= 0):
			BuildManager.AbleToBuild = true

func SetDisabled(disabled : bool):
	$collisionShape2.disabled = disabled
	
