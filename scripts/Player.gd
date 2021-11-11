extends Sprite

var speed = 150 # Player speed.
var velocity = Vector2()

var bullet = preload("res://scenes/Bullet.tscn") # Calling bullet scene.

var can_shoot = true # Ability for player to shoot.
var is_dead = false

func _ready():
	Global.player = self
	
func _exit_tree():
	Global.player = null

func _process(delta): # Function is called every frame, however 'delta' acts as the time delay between frames and is
					  # passed into the function.
	velocity.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")) 
	velocity.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	velocity = velocity.normalized() # Smooth player movement at all angles.
	
	if is_dead == false:
		global_position += speed * velocity * delta
	
	if Input.is_action_pressed("click") and Global.node_creation_parent != null and can_shoot and is_dead == false: # Player Shooting
		Global.instance_node(bullet, global_position, Global.node_creation_parent)
		$Reload_speed.start() # Reload Cooldown
		can_shoot = false

func _on_Reload_speed_timeout(): # Once cooldown is over, run function.
	can_shoot = true 

func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy"):
		is_dead = true
		visible = false
		yield(get_tree().create_timer(1.5), "timeout")
		get_tree().reload_current_scene()
