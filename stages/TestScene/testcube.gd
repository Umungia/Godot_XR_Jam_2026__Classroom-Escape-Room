extends MeshInstance3D


func _ready():
	var boton = get_node_or_null("/root/MainStaging/Scene/TestScene/PushButton/InteractableAreaButton")
	if boton == null:
		push_error("No encuentro InteractableAreaButton en esa ruta")
		return
	boton.button_pressed.connect(_on_button_pressed)

@export var delay: float = 0.3
var _esperando := false

func _on_button_pressed(button):
	if _esperando:
		return
	_esperando = true
	await get_tree().create_timer(delay).timeout
	if not is_inside_tree():
		return
	visible = not visible
	_esperando = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
