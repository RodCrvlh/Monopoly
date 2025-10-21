extends CenterContainer
class_name prisao_box

@onready var mensagem: Label = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var hbox: HBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/Hbox

#botao sim
func _on_button_pressed() -> void:
	hbox.visible = false  

func _input(event: InputEvent) -> void:
	if hbox.visible == false and Input.is_action_just_pressed("ui_click"):
		Events.emit_signal("box_acabou")
		queue_free()


func _on_ok_pressed() -> void:
	pass # Replace with function body.
