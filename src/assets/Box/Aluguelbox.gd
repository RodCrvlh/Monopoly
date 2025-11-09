extends CenterContainer
class_name Aluguel_box

signal pagar_aluguel(espaco: Espaco)

@onready var mensagem: Label = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var hbox: HBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/Hbox
var preco_compra: int
var espaco_utilizado

func _ready() -> void:
	pass

func set_mensagem(p:int) -> void:
	if is_instance_valid(mensagem):
		mensagem.text += str(p)
	
	else:
		print("Error")

func set_espaco(espaco: Espaco):
	espaco_utilizado = espaco
	
func _on_ok_pressed() -> void:
	hbox.visible = false  
	
func _input(event: InputEvent) -> void:
	if hbox.visible == false and Input.is_action_just_pressed("ui_click"):
		emit_signal("pagar_aluguel", espaco_utilizado)
		
		queue_free()
