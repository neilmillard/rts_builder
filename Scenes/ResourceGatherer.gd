extends KinematicBody

enum Task{
	GettingResources,
	Searching,
	Delivering,
	Walking
}

var CurrentTask = Task.Searching
var Hut
var HeldResourceAmount := 0
export var WalkSpeed := 6
export var ResourceGenerationAmount := 0

onready var navagent : NavigationAgent = $NavigationAgent
var runOnce := true
export(String, "stone", "tree", "iron") var ResourceNameToGet

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match CurrentTask:
		Task.GettingResources:
			if runOnce:
				runOnce = false
				yield(get_tree().create_timer(2.0), "timeout")
				runOnce = true
				HeldResourceAmount = ResourceGenerationAmount
				CurrentTask = Task.Delivering
			pass
		Task.Searching:
			var resources = get_tree().get_nodes_in_group(ResourceNameToGet)
			var nearestResourceObject = resources[0]
			for i in resources:
				if i.translation.distance_to(translation) < nearestResourceObject.translation.distance_to(translation):
					nearestResourceObject = i
			navagent.set_target_location(nearestResourceObject.global_translation)
			CurrentTask = Task.Walking
			pass
		Task.Delivering:
			var stockpiles = get_tree().get_nodes_in_group("Stockpile")
			if len(stockpiles) == 0:
				return
			var nearestStockpileObject = stockpiles[0]
			for i in stockpiles:
				if i.translation.distance_to(translation) < nearestStockpileObject.translation.distance_to(translation):
					if i.spawned:
						nearestStockpileObject = i
			navagent.set_target_location(nearestStockpileObject.get_node("SpawnPoint").global_translation)
			CurrentTask = Task.Walking
		Task.Walking:
			if navagent.is_navigation_finished():
				if HeldResourceAmount == 0:
					CurrentTask = Task.GettingResources
				else:
					match ResourceNameToGet:
						"stone":
							GameManager.Stone += HeldResourceAmount
						"tree":
							GameManager.Wood += HeldResourceAmount
						"iron":
							GameManager.Iron += HeldResourceAmount
					HeldResourceAmount = 0
					CurrentTask = Task.Searching
				return
			var targetpos = navagent.get_next_location()
			var direction = global_translation.direction_to(targetpos)
			var velocity = direction * WalkSpeed
			move_and_slide(velocity)
			pass
	$Label3D.text = str(CurrentTask)		
	pass
