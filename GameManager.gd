extends Node

enum State{
	Play,
	Build,
	Destroying
}

var CurrentState = State.Play

var Wood := 30
var Stone := 20
var Gold := 100
var Iron := 0
var Food := 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
