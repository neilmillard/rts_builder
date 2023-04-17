extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	# Update interface (could do this on event driven system i.e. after a value is updated
	$Control/VBoxContainer/Wood/WoodValue.text = str(GameManager.Wood)
	$Control/VBoxContainer/Stone/StoneValue.text = str(GameManager.Stone)
	$Control/VBoxContainer/Iron/IronValue.text = str(GameManager.Iron)
	$Control/VBoxContainer/Food/FoodValue.text = str(GameManager.Food)
	$Control/VBoxContainer/Gold/GoldValue.text = str(GameManager.Gold)
	
	pass


func _on_BuildWoodCutterButton_button_down():
	BuildManager.SpawnWoodcutter()
	pass # Replace with function body.


func _on_Area2D_area_entered(area):
	BuildManager.AbleToBuild = false
	pass # Replace with function body.


func _on_Area2D_area_exited(area):
	BuildManager.AbleToBuild = true
	pass # Replace with function body.


func _on_BuildStockpile_button_down():
	BuildManager.SpawnStockPile()
	pass # Replace with function body.


func _on_BuildStoneCutterButton_button_down():
	BuildManager.SpawnStoneCutter()
	pass # Replace with function body.

func _on_BuildIronWorker_button_down():
	BuildManager.SpawnIronWorker()
	pass # Replace with function body.

func _on_BuildGranary_button_down():
	BuildManager.SpawnGranary()
	pass # Replace with function body.

func _on_Orchard_button_down():
	BuildManager.SpawnOrchard()
	pass # Replace with function body.
	
func _on_BuildHouse_button_down():
	BuildManager.SpawnHouse()
	pass # Replace with function body.

func _on_BuildWallNarrow_button_down():
	BuildManager.SpawnNarrowWall()
	pass # Replace with function body.

