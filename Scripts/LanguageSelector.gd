extends Node3D

const LOCALES := ["eu", "es", "en"]
const LANGUAGE_NAMES := ["Euskara", "Español", "English"]
const SELECT_THRESHOLD := 0.65
const RELEASE_THRESHOLD := 0.25
const SELECTED_COLOR := Color.WHITE
const UNSELECTED_COLOR := Color(0.5, 0.5, 0.5)

var _selected_index := 0
var _stick_ready := false

@onready var _left_controller: XRController3D = get_node("../../../XROrigin3D/LeftHandController")
@onready var _right_controller: XRController3D = get_node("../../../XROrigin3D/RightHandController")
@onready var _hold_button = get_node("../HoldButton")
@onready var _labels: Array[Label3D] = [$Basque, $Spanish, $English]


func _ready() -> void:
	var current_language := TranslationServer.get_locale().get_slice("_", 0)
	_select_language(maxi(LOCALES.find(current_language), 0))


func _process(_delta: float) -> void:
	# Only accept selection while the startup prompt is waiting for confirmation.
	if not is_visible_in_tree() or not _hold_button.enabled or _hold_button.time_held > 0.0:
		_stick_ready = false
		return

	var left := _left_controller.get_vector2("primary")
	var right := _right_controller.get_vector2("primary")
	var stick := left if absf(left.x) > absf(right.x) else right
	if absf(stick.x) < RELEASE_THRESHOLD:
		_stick_ready = true
	elif _stick_ready and absf(stick.x) >= SELECT_THRESHOLD and absf(stick.x) > absf(stick.y):
		# Both sticks must return to centre before another language can be selected.
		_stick_ready = false
		var direction := 1 if stick.x > 0.0 else -1
		_select_language(posmod(_selected_index + direction, LOCALES.size()))


func _select_language(index: int) -> void:
	_selected_index = index
	TranslationServer.set_locale(LOCALES[index])
	for i in range(_labels.size()):
		var selected := i == index
		_labels[i].text = "[ %s ]" % LANGUAGE_NAMES[i] if selected else LANGUAGE_NAMES[i]
		_labels[i].modulate = SELECTED_COLOR if selected else UNSELECTED_COLOR
