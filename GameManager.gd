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
var firePitSpaces : Array
var occupiedFirePitSpaces : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	Citizen = ResourceLoader.load("res://Assets/Citizen.tscn")
	firePitSpaces = get_tree().get_nodes_in_group("CitizenSpawnPoint")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Population < MaxPopulation && spawnReady && Happiness > 0 && firePitSpaces.size() > 0:
		spawnReady = false
		yield(get_tree().create_timer(3.0), "timeout")
		spawnReady = true
		var citizen = Citizen.instance()
		firePitSpaces[0].add_child(citizen)
		citizen.FirePitPosition = firePitSpaces[0]
		citizen.SpawnObjectSetup()
		occupiedFirePitSpaces.append(firePitSpaces.pop_front())
		Population += 1
		AvailablePopulation += 1
	elif spawnReady && Happiness < 0:
		spawnReady = false
		yield(get_tree().create_timer(3.0), "timeout")
		spawnReady = true
		if AvailablePopulation > 0:
			RemoveCitizen(1)
			
func RemoveCitizen(Cost : int):
	for i in range(0, Cost, 1):
		firePitSpaces.append(occupiedFirePitSpaces[0])
		var temp : Spatial = occupiedFirePitSpaces[0]
		delete_children(temp)
		occupiedFirePitSpaces.remove(0)
		AvailablePopulation -= 1
		
func delete_children(node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
		
			
	pass
