extends CenterContainer
class_name  VendaBox

signal compra_sim(espaco: Espaco)
signal compra_nao(espaco: Espaco)

@export var sim: bool
@onready var mensagem: Label = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var v_box_container: VBoxContainer = $PanelContainer/MarginContainer/VBoxContainer
var hboxs_propriedades: Array [HBoxContainer]
var labels_propriedades: Array[Label]
var botoes_sim: Array[Button]
var botoes_nao: Array[Button]
var nome_jogador: String
var propriedades_possuidas: Array[Espaco]
var divida


func _ready() -> void:
	pass

func set_mensagem() -> void:
	if is_instance_valid(mensagem):
		mensagem.text = "Venda as suas propriedades para pagar a sua divida"
	
	else:
		print("Error")

func set_nome_jogador(nome: String):
	nome_jogador = nome


func set_propriedades_possuidas(propriedades: Array[Espaco], valores_propriedades: Array[int]):
	propriedades_possuidas = propriedades.duplicate()
	
	var i = 0
	labels_propriedades.resize( propriedades.size())
	botoes_sim.resize( propriedades.size())
	botoes_nao.resize(propriedades.size())
	
	while i < propriedades.size():
		var novo_hbox = HBoxContainer.new()
		var nova_label = Label.new()
		var novo_botao_sim = Button.new()
		var novo_botao_nao = Button.new()
		
		nova_label.text = propriedades[i].nome+" valor: R$"+valores_propriedades[i]
		novo_botao_sim.connect(_on_botao_sim_pressed)
		novo_botao_nao.connect(_on_botao_nao_pressed)
		
		hboxs_propriedades = novo_hbox
		labels_propriedades[i] = nova_label
		labels_propriedades[i] = novo_botao
		
		v_box_container.add_child(novo_hbox)
		novo_hbox.add_child(nova_label)
		novo_hbox.add_child(novo_botao)
		
		


func set_divida(d: int):
	divida = d

#botao sim
func _on_botao_sim_pressed() -> void:

func _on_botao_nao_pressed(): -> void:
	
	

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_click"):
		
	
		queue_free()
