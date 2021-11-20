extends Sprite

var speed = 180 # Player speed.
var velocity = Vector2()

var bullet = preload("res://scenes/Bullet.tscn") # Calling bullet scene.

var can_shoot = true # Ability for player to shoot.
var is_dead = false

func _ready():
	Global.player = self
	
func _exit_tree():
	Global.player = null

func _process(delta): # Function is called every frame, however 'delta' acts as the time delay between
					  # frames and is passed into the function.
	velocity.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")) 
	velocity.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	velocity = velocity.normalized() # Smooth player movement at all angles.
	
	global_position.x = clamp(global_position.x, 16, 624) # Stop player from leaving camera scene in x value.
	global_position.y = clamp(global_position.y, 16, 344) # Stop player from leaving camera scene in y value.
	
	if is_dead == false: # Checks if player dead.
		global_position += speed * velocity * delta # Player can continue moving normally.
	
	if Input.is_action_pressed("click") and Global.node_creation_parent != null and can_shoot and is_dead == false: # Player Shooting
		Global.instance_node(bullet, global_position, Global.node_creation_parent)
		$Reload_speed.start() # Reload Cooldown
		can_shoot = false # Tempoaraily disables shooting

func _on_Reload_speed_timeout(): # Once cooldown is over, run function.
	can_shoot = true # Player can once again shoot.

func _on_Hitbox_area_entered(area): # If enemy collides with player.
	if area.is_in_group("Enemy"):
		is_dead = true # Sets players status to dead.
		visible = false # Hide's player.
		if Global.camera != null:
			Global.camera.screen_shake(20, 0.5) # Shake camera on players death.
		yield(get_tree().create_timer(1.5), "timeout") # Cooldown for 1.5 seconds before player starts playing again.
		get_tree().reload_current_scene() # REload scene, put player back in center, reset score and remove enemies.
