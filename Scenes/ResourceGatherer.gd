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
export var WalkSpeed : int = 6

onready var navagent : NavigationAgent = $NavigationAgent
var runOnce := true


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
				HeldResourceAmount = 5
				CurrentTask = Task.Delivering
			pass
		Task.Searching:
			var resources = get_tree().get_nodes_in_group("tree")
			if resources.size() > 0:
				navagent.set_target_location(resources[0].global_translation)
			CurrentTask = Task.Walking
			pass
		Task.Delivering:
			navagent.set_target_location(Hut)
			CurrentTask = Task.Walking
			pass
		Task.Walking:
			if navagent.is_navigation_finished():
				if HeldResourceAmount == 0:
					CurrentTask = Task.GettingResources
				else:
					GameManager.Wood += HeldResourceAmount
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
