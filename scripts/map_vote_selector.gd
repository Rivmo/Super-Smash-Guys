extends VBoxContainer

var MapVotes := [0,0,0,0,0] # The first index is A TEMPORARY, but do NOT remove it because otherwise the last voted function is poopy head
var MapLastVoted := 0
var MapVoted := 0
var IsMapChosen := false
@onready var VoteTimerLabel = $"../MarginContainer/Panel/Label"
@onready var MapVoteTimer = $"../MapVoteTimer"
func _process(delta: float) -> void:
	$HBoxContainer2/Label.text = str(MapVotes[1])
	$HBoxContainer2/Label2.text = str(MapVotes[2])
	$HBoxContainer2/Label3.text = str(MapVotes[3])
	$HBoxContainer2/Label4.text = str(MapVotes[4])
	VoteTimerLabel.text = str(MapVoteTimer.time_left).substr(0,4)
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
	elif selectedmap == 2:
		print("Loading map 2")
	elif selectedmap == 3:
		print("Loading map 3")
	elif selectedmap == 4:
		print("Loading map 4")
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
