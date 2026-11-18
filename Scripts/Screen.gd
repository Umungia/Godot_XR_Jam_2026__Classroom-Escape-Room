extends StaticBody3D

const CORRECT_ANSWER_SOUND: AudioStream = preload("res://Audio/usb_insert_exaggerated.wav")
const WRONG_ANSWER_SOUND: AudioStream = preload("res://Audio/usb_wrong_order.wav")


@onready var snap_zone: XRToolsSnapZone = $SnapZone
@onready var screenOn: MeshInstance3D = $instruction_panel2/instruction_panel/instruction_faceOn
@onready var screenOff: MeshInstance3D = $instruction_panel2/instruction_panel/instruction_face

func _ready() -> void:
	snap_zone.has_picked_up.connect(_on_picked_up)
	snap_zone.has_dropped.connect(_on_dropped)


func _on_picked_up(_what):
	pass

func _on_dropped():
	pass


func play_answer_sound(correct: bool) -> void:
	# Reuse the dock's spatial player and let the latest answer replace its cue.
	var audio_player: AudioStreamPlayer3D = $SnapZone/AudioStreamPlayer3D
	audio_player.stop()
	audio_player.stream = CORRECT_ANSWER_SOUND if correct else WRONG_ANSWER_SOUND
	audio_player.play()
