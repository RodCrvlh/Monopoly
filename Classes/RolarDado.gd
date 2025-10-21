extends CenterContainer
class_name Prisao_box

@onready var mensagem: Label = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var hbox: HBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/Hbox

#botao sim
func _on_ok_pressed() -> void:
		mensagem.text = "Resultado"
		hbox.visible = false  

func _input(event: InputEvent) -> void:
	if hbox.visible == false and Input.is_action_just_pressed("ui_click"):
		queue_free()
