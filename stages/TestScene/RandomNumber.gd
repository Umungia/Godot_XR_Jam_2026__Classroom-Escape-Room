extends StaticBody3D
@onready var randNum

func _ready() -> void:
	randNum = randi_range(1,3)


func _process(delta: float) -> void:
	pass
