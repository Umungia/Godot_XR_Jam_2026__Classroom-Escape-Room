extends StaticBody3D

@onready var anim = $AnimationPlayer

func _on_area_3d_area_entered(area):
		anim.play("presseddown")
		print("Pressed!")
func _on_area_3d_area_exited(area):
		anim.play("pressedup")
		print("Unpressed!")
