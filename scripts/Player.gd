extends Sprite

var speed = 150 # Player speed.
var velocity = Vector2()

var bullet = preload("res://scenes/Bullet.tscn") # Calling bullet scene.

var can_shoot = true # Ability for player to shoot.

func _ready():
	Global.player = self
	
func _exit_tree():
	Global.player = null

func _process(delta): # Function is called every frame, however 'delta' acts as the time delay between frames and is
					  # passed into the function.
	velocity.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")) 
	velocity.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))
	
	velocity = velocity.normalized() # Smooth player movement at all angles.
	
	global_position += speed * velocity * delta
	
	if Input.is_action_pressed("click") and Global.node_creation_parent != null and can_shoot: # Player Shooting
		Global.instance_node(bullet, global_position, Global.node_creation_parent)
		$Reload_speed.start() # Reload Cooldown
		can_shoot = false

func _on_Reload_speed_timeout(): # Once cooldown is over, run function.
	can_shoot = true 
