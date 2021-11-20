extends Label

func _process(delta):
	text = "High Score: " + String(Global.highscore) # Write declared value in global script to label node.

	
	if Global.points > Global.highscore: # If score is higher than higherscore, update value.
		Global.highscore = Global.points
