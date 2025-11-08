extends CenterContainer
class_name Aluguel_box

@onready var mensagem: Label = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var hbox: HBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/Hbox
var comprou: bool
var preco_compra: int

func _ready() -> void:
	pass

func setMensagem(p:int) -> void:
	if is_instance_valid(mensagem):
		mensagem.text += str(p)
	
	else:
		print("Error")

func _on_ok_pressed() -> void:
	hbox.visible = false  
	
func _input(event: InputEvent) -> void:
	if hbox.visible == false and Input.is_action_just_pressed("ui_click"):
		if comprou:
			Events.emit_signal("compra_sim")
		
		Events.emit_signal("box_acabou")
		queue_free()
