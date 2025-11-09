extends CenterContainer
class_name Comprar_Box

signal compra_sim(espaco: Espaco)
signal compra_nao(espaco: Espaco)

@export var sim: bool
@onready var mensagem: Label = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var hbox: HBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/Hbox
var comprou: bool
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
	
#botao sim
func _on_sim_pressed() -> void:
	mensagem.text = "Propriedade comprada"
	hbox.visible = false 
	comprou = true
		
#botao nao	
func _on_nao_pressed() -> void:
	mensagem.text = "Propriedade não comprada!"
	hbox.visible = false 
	comprou = false

func _input(event: InputEvent) -> void:
	if hbox.visible == false and Input.is_action_just_pressed("ui_click"):
		if comprou:
			emit_signal("compra_sim", espaco_utilizado)
		else:
			emit_signal("compra_nao", espaco_utilizado)
	
		queue_free()
