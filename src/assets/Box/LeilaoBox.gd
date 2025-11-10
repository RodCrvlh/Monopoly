extends CenterContainer
class_name LeilaoBox

signal player_saiu()
signal novo_lance(novo_lance: int)

@onready var digita_valor: LineEdit = $PanelContainer/MarginContainer/VBoxContainer/DigitaValor
@onready var mensagem: Label = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var hbox: HBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/Hbox
var lance_feito: bool = false
var sair: bool = false
var nome_jogador_atual
var valor_lance: int


func _ready() -> void:
	digita_valor.text_submitted.connect(on_valor_lance_modificado)


func set_valor_lance(valor: int):
	valor_lance = valor


func set_nome_jogador_atual(nome_jogador: String):
	nome_jogador_atual = nome_jogador


func set_mensagem_lance(lance:int) -> void:
	if is_instance_valid(mensagem):
		mensagem.text += "É hora do Leilao!\nVez do "+nome_jogador_atual+"\n Maior Lance:"+str(lance)
	
	else:
		print("Error")


func set_mensagem_dinheiro_insuficiente():
	mensagem.text = "Voce nao tem dinheiro para fazer esse lance"


func on_valor_lance_modificado(valor: String):
	valor_lance = valor as int

#botao lance
func _on_lance_pressed() -> void:
	hbox.visible = false 
	lance_feito = true


#botao sair	
func _on_sair_pressed() -> void:
	mensagem.text =+ nome_jogador_atual+" saiu do leilao!"
	hbox.visible = false 
	sair = true


func _input(event: InputEvent) -> void:
	if hbox.visible == false and Input.is_action_just_pressed("ui_click"):
		
		if sair:
			emit_signal("player_saiu")
		
		else:
			emit_signal("novo_lance", valor_lance)


func destruir_box():
	queue_free()
