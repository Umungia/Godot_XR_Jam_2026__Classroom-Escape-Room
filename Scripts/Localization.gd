extends Node


func _enter_tree() -> void:
	# Debug language: "eu" (Basque), "es" (Spanish), or "en" (English).
	TranslationServer.set_locale("eu")
