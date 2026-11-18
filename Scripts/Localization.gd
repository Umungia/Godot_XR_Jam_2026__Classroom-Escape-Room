extends Node


func _enter_tree() -> void:
	# Startup default; the splash-screen selector can change it for this session.
	# Also used when running the classroom scene directly for debugging.
	TranslationServer.set_locale("eu")
