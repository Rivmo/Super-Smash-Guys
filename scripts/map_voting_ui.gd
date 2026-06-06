extends Control

# ADDING MORE MAPS (instructions)
# add one more 0 to the MapVotes variable
# add an elif statement for selecting your new map in the loadmap function
# add another label & button to the ui, also make sure tha the text is being updated in the _process function
# I may edit this code to be better later - river

var MapVotes := [0,0,0,0,0] # The first index is A TEMPORARY, but do NOT remove it because otherwise the last voted function is poopy head
var MapLastVoted := 0
var MapVoted := 0
var IsMapChosen := false
var votedtoskip := false
var totalvotesforskip := 0
var votesneededtoskip := 1
const map_placeholder = preload("res://scenes/maps/map_placeholder.tscn")
const placeholder_arena = preload("res://scenes/maps/placeholder_arena.tscn")
@onready var VoteTimerLabel = $ColorRect/MarginContainer/Panel/Label
@onready var MapVoteTimer = $ColorRect/MapVoteTimer
func _process(delta: float) -> void:
	$ColorRect/VBoxContainer/HBoxContainer2/Label.text = str(MapVotes[1])
	$ColorRect/VBoxContainer/HBoxContainer2/Label2.text = str(MapVotes[2])
	$ColorRect/VBoxContainer/HBoxContainer2/Label3.text = str(MapVotes[3])
	$ColorRect/VBoxContainer/HBoxContainer2/Label4.text = str(MapVotes[4])
	
	$ColorRect/MarginContainer2/VBoxContainer/votesneeded.text = (str(totalvotesforskip) + "/" + str(votesneededtoskip))
	
	if totalvotesforskip >= votesneededtoskip:
		MapVoteTimer.stop()
	
	if MapVoteTimer.time_left >= 10:
		VoteTimerLabel.text = (str(MapVoteTimer.time_left).substr(0,4)+"s")
	else:
		VoteTimerLabel.text = (str(MapVoteTimer.time_left).substr(0,3)+"s")
	if MapVoteTimer.time_left == 0.0 and IsMapChosen == false:
		loadmap()

func getmostvoted(Votes):
	var potential := [0] # Number of votes on potential maps, map numbers
	for index in range(1, len(Votes)):
		if potential[0] < Votes[index]: # If the votes for a selected map are more than a previous one
			potential = [] # Clear the list
			potential.append(Votes[index]) # Write the number of votes that chose this map
			potential.append(index) # Write which map has potential to be chosen
		elif potential[0] == Votes[index]: # If the votes for a selected map are tied with a previous one
			potential.append(index) # Put that map number in the potential pool
	var chosenmap = potential[randi_range(1, len(potential)-1)]
	IsMapChosen = true # The map has now been chosen
	return chosenmap

func loadmap() -> void:
	var selectedmap = getmostvoted(MapVotes)
	if selectedmap == 1:
		print("Loading map 1")
		get_tree().current_scene.add_child(map_placeholder.instantiate())
		$ColorRect.visible = false
	elif selectedmap == 2:
		print("Loading map 2")
		get_tree().current_scene.add_child(placeholder_arena.instantiate())
		$ColorRect.visible = false
	elif selectedmap == 3:
		print("Loading map 3")
		
		$ColorRect.visible = false
	elif selectedmap == 4:
		print("Loading map 4")
		
		$ColorRect.visible = false
	else:
		print("Error, Map not found, please contact River")

func ReassignVotes(selectedmap) -> void:
	MapVotes[MapLastVoted] -= 1
	MapVotes[selectedmap] += 1
	MapLastVoted = selectedmap

func _on_button_pressed() -> void:
	ReassignVotes(1)
func _on_button_2_pressed() -> void:
	ReassignVotes(2)
func _on_button_3_pressed() -> void:
	ReassignVotes(3)
func _on_button_4_pressed() -> void:
	ReassignVotes(4)
func _on_skipvotingbutton_pressed() -> void:
	if votedtoskip == false:
		totalvotesforskip += 1
		votedtoskip = true
