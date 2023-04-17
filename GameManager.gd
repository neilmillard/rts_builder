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

var Population : int = 0
var MaxPopulation : int = 4
var AvailablePopulation : int = 0
var Citizen : PackedScene
var Happiness := 1

var spawnReady := true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Population < MaxPopulation && spawnReady && Happiness > 0:
		spawnReady = false
		yield(get_tree().create_timer(3.0), "timeout")
		spawnReady = true
		Population += 1
		AvailablePopulation += 1
	elif spawnReady && Happiness < 0:
		spawnReady = false
		yield(get_tree().create_timer(3.0), "timeout")
		spawnReady = true
		if AvailablePopulation > 1:
			AvailablePopulation -= 1
			
	pass
