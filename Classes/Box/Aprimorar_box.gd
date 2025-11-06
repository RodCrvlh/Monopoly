extends CenterContainer
class_name Aprimora_box

@export var sim: bool
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

#botao sim
func _on_sim_pressed() -> void:
	mensagem.text = "Propriedade foi melhorada"
	hbox.visible = false 
	comprou = true
		
#	
func _on_nao_pressed() -> void:
	mensagem.text = "Propriedade não foi melhorada!"
	hbox.visible = false 
	comprou = false

func _input(event: InputEvent) -> void:
	if hbox.visible == false and Input.is_action_just_pressed("ui_click"):
		if comprou:
			Events.emit_signal("compra_sim")
		
		Events.emit_signal("box_acabou")
		queue_free()

 
