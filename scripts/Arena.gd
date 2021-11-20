extends Node2D

var enemy_1 = preload("res://scenes/Enemy.tscn")

func _ready():
	Global.node_creation_parent = self
	
	Global.points = 0
	
func _exit_tree():
	Global.node_creation_parent = null


func _on_Enemy_spawn_timer_timeout():
	var enemy_position = Vector2(rand_range(-160, 670), rand_range(-90, 390)) # Random enemy position to spawn, can be
																			  # anywhere within a certain range outside
																			  # the camera view.
	
	while enemy_position.x < 640 and enemy_position.x > -80 and enemy_position.y < 360 and enemy_position.y > -45:
		enemy_position = Vector2(rand_range(-160, 670), rand_range(-90, 390)) # Make sure enemies dont spawn inside the
																			  # camera view.
	
	Global.instance_node(enemy_1, enemy_position, self)

func _on_Difficulty_timer_timeout():
	if $Enemy_spawn_timer.wait_time > 0.5: # Cap out at certain point so data doesn't become exponential.
		$Enemy_spawn_timer.wait_time -= 0.1 # Decrease the sleep time in between spawn rates.

