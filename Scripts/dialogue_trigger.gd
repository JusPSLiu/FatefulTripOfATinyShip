extends Area3D

@export var my_dialogue : int = 0

@onready var GUI = get_parent().get_node("GUI")

func _on_body_entered(body: Node3D) -> void:
	if (body.is_in_group("Player")):
		GUI.play_dialogue(my_dialogue)
