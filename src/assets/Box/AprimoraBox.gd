extends CenterContainer
class_name AprimoraBox

signal aprimora_credito(espaco_utilizado: Espaco, player: Player)

@onready var mensagem: Label = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var hbox: HBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/Hbox
var aprimorou: bool
var espaco_utilizado
var player

func _ready() -> void:
	pass

func set_player(player_atual: Player):
		player = player_atual
		
func set_mensagem(valor_casa:int) -> void:
	if is_instance_valid(mensagem):
		mensagem.text += str(valor_casa)
	
	else:
		print("Error")

func set_espaco(espaco: Espaco):
	espaco_utilizado = espaco
	
#botao sim
func _on_sim_pressed() -> void:
	mensagem.text = "Disciplina foi melhorada"
	hbox.visible = false 
	aprimorou = true
	destruir()


func _on_nao_pressed() -> void:
	mensagem.text = "Disciplina não foi melhorada!"
	hbox.visible = false 
	aprimorou = false
	destruir()

func destruir() -> void:
		if aprimorou and espaco_utilizado is Disciplina:
			espaco_utilizado.aprimora_credito()
			emit_signal("aprimora_credito", espaco_utilizado, player)
	
		queue_free()
