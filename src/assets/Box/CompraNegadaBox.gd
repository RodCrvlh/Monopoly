extends CenterContainer
class_name CompraNegadaBox

@onready var hbox: HBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/Hbox

func _on_ok_pressed() -> void:
	hbox.visible = false  
	
func _input(event: InputEvent) -> void:
	if hbox.visible == false and Input.is_action_just_pressed("ui_click"):
		queue_free()
