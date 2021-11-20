extends Sprite

var speed = 75 # Movement Speed

var velocity = Vector2()

var stun = false # Stop enemy movement.
var hp = 3 # Enemy HP

var blood_particles = preload("res://scenes/Blood_particles.tscn") # Load blood particle scene.

func _process(delta):
	if Global.player != null and stun == false:
		velocity = global_position.direction_to(Global.player.global_position)
	elif stun:
		velocity = lerp(velocity, Vector2(0, 0), 0.3) # Stop players movement tempoarialy as currently stunned.
	
	global_position += velocity * speed * delta # Enemys movement
	
	if hp <= 0: # When health is 0
		if Global.camera != null:
			Global.camera.screen_shake(20, 0.1) # Shake camera.
		
		Global.points += 10 # Add 10 points after enemy death
		if Global.node_creation_parent != null:
			var blood_particles_instance = Global.instance_node(blood_particles, global_position, Global.node_creation_parent)
			blood_particles_instance.rotation = velocity.angle() # Create blood particles, rotate according to angle player
																 # was shooting enemy.
		
		queue_free() # Destory enemy.

func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy_damager") and stun == false:
		modulate = Color("EB5E9D") # Change colour of enemy when hit.
		velocity = -velocity * 6
		hp -= 1 # Remove 1 HP.
		stun = true # Stun enemy.
		$Stun_timer.start() # Start stun cooldown.
		area.get_parent().queue_free()


func _on_Stun_timer_timeout(): # When timeout finishes.
	modulate = Color("d72b78") # Set colour back to normal enemy colour.
	stun = false # Disable stun.
