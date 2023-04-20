extends KinematicBody

enum Task{
	Walking,
	Sitting
}

var FirePitPosition : Position3D
onready var navagent: NavigationAgent = $NavigationAgent
var currentTask = Task.Walking
export var WalkSpeed := 6

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func SpawnObjectSetup():
	navagent.set_target_location(FirePitPosition.global_translation)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match currentTask:
		Task.Sitting:
			pass
		Task.Walking:
			if navagent.is_navigation_finished():
				currentTask = Task.Sitting
				return
				
			var targetpos = navagent.get_next_location()
			var direction = global_translation.direction_to(targetpos)
			var velocity = direction * WalkSpeed
			move_and_slide(velocity)
	pass
