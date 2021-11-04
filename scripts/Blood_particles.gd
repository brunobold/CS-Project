extends CPUParticles2D

onready var Blood_timeout = get_node("Blood_timeout")
onready var Timeout_wait = get_node("Timeout_wait")

func _on_Freeze_blood_timeout():
	set_process(false)
	set_physics_process(false)
	set_process_input(false)
	set_process_internal(false)
	set_process_unhandled_input(false)
	set_process_unhandled_key_input(false)
	Blood_timeout.start()

func _on_Timeout_wait_timeout():
	modulate.a -= 0.1

func _on_Blood_timeout_timeout():
	for x in range(10):
		Timeout_wait.start()
