extends CenterContainer
class_name LeilaoBox

signal player_saiu(leilao: ControleLeilao)
signal dar_lance(valor_lance: int)
signal terminou()

@onready var hbox: HBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/Hbox
@onready var label_nome_jogador: Label = $PanelContainer/MarginContainer/VBoxContainer/NomeJogador
@onready var digita_valor: LineEdit = $PanelContainer/MarginContainer/VBoxContainer/DigitaValor
@onready var mensagem: Label = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var timer: Timer = $Timer

var lance_feito: bool = false
var sair: bool = false
var nome_jogador_atual
var valor_lance: int
var valor_lance_antigo: int



func _ready() -> void:
	digita_valor.text_submitted.connect(on_valor_lance_modificado)

func ativar_timer():
	timer.start()
	await(timer.timeout)
	

func set_nome_jogador_atual(nome_jogador: String):
	nome_jogador_atual = nome_jogador
	label_nome_jogador.text = "É hora do Leilao!\nVez do "+nome_jogador_atual
	


func set_mensagem_lance(lance:int) -> void:
	if is_instance_valid(mensagem):
		mensagem.text = "Maior Lance: R$"+str(lance)
		
	else:
		print("Error")


func set_mensagem_dinheiro_insuficiente():
	label_nome_jogador.text = "Voce nao tem dinheiro para fazer esse lance, tente outro lance menor!"
	valor_lance = valor_lance_antigo
	await(ativar_timer())
	print("timer nao funciona")
	set_nome_jogador_atual(nome_jogador_atual)



func set_mensagem_final(nome_vencedor: String):
	if nome_vencedor == "":
		label_nome_jogador.text = "Ninguem comprou esta propriedade!"
		mensagem.text = ""
	
	else:
		label_nome_jogador.text = nome_vencedor+" é o vencedor do leilao!"
		mensagem.text = ""
	
	hbox.visible = false
	digita_valor.visible = false
	emit_signal("terminou")
	await(ativar_timer())
	destruir_box()

func set_mensagem_lance_menor():
	label_nome_jogador.text = nome_jogador_atual+" seu lance é menor que o maior lance"
	await(ativar_timer())
	print("timer nao funciona")
	set_nome_jogador_atual(nome_jogador_atual)

func on_valor_lance_modificado(valor: String):
	var novo_valor = valor as int
	if valor_lance < novo_valor:
		valor_lance = novo_valor


func get_valor_lance():
	return valor_lance


#botao lance
func _on_lance_pressed() -> void:
	lance_feito = true
	emitir_sinal()


#botao sair	
func _on_sair_pressed() -> void:
	sair = true
	label_nome_jogador.text = nome_jogador_atual+" saiu do leilao!"
	emitir_sinal()


func emitir_sinal() -> void:
	if sair:
		emit_signal("player_saiu")
		sair = false
		
	if lance_feito:
		emit_signal("dar_lance", valor_lance)
		lance_feito = false


func destruir_box():
	queue_free()
