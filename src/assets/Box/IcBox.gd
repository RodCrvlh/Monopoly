extends CenterContainer
class_name Ic_Box

@onready var mensagem: Label = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var hbox: HBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/Hbox

func _on_ok_pressed() -> void:
	hbox.visible = false  
	
func set_mensagem(texto: String):
	mensagem.text = texto

func _input(event: InputEvent) -> void:
	if hbox.visible == false and Input.is_action_just_pressed("ui_click"):
		emit_signal("box_acabou")
		queue_free()
