extends Node
class_name BoxFim

signal fim()

@onready var label: Label = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var hbox: HBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/Hbox

func set_label(texto: String):
	label.text = texto
	
func _on_ok_pressed() -> void:
	hbox.visible = false  
	
func _input(event: InputEvent) -> void:
	if hbox.visible == false and Input.is_action_just_pressed("ui_click"):
		emit_signal("fim")
		queue_free()
