extends Camera2D

var screen_shake_start = false
var shake_intensity = 0

func _ready():
	Global.camera = self

func _exit_tree():
	Global.camera = null

func _process(delta):
	zoom = lerp(zoom, Vector2(1, 1), 0.3)
	
	if screen_shake_start == true:
		global_position += Vector2(rand_range(-shake_intensity, shake_intensity), rand_range(-shake_intensity, shake_intensity)) * delta#

func screen_shake(intensity, time):
	zoom = Vector2(1, 1) - Vector2(intensity * 0.002, intensity * 0.02)
	shake_intensity = intensity
	$Screen_shake_time.wait_time = time
	$Screen_shake_time.start()
	screen_shake_start = true
	pass

func _on_Screen_shake_time_timeout():
	screen_shake_start = false
	global_position = Vector2(320, 180)
