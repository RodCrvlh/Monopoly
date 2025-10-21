extends CenterContainer
class_name Comprar_Box

@export var sim_e_correto: bool
@onready var mensagem: Label = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var hbox: HBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/Hbox

#botao sim
func _on_sim_pressed() -> void:
	if sim_e_correto:
		mensagem.text = "Propriedade não comprada"
		hbox.visible = false 
		
	else:
		mensagem.text = "Propriedade comprada!"
		hbox.visible = false 

#	
func _on_nao_pressed() -> void:
	if sim_e_correto:
		mensagem.text = "Propriedade comprada!"
		hbox.visible = false 
		
	else:
		mensagem.text = "Propriedade não comprada!"
		hbox.visible = false 

func _input(event: InputEvent) -> void:
	if hbox.visible == false and Input.is_action_just_pressed("ui_click"):
		Events.emit_signal("box_acabou")
		queue_free()
