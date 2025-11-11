extends CenterContainer
class_name  VendaBox

signal venda_acabou(propriedades_vendidas: Array[bool])

@onready var label_titulo: Label = $PanelContainer/MarginContainer/VBoxContainer/Titulo
@onready var label_divida: Label = $PanelContainer/MarginContainer/VBoxContainer/Divida
@onready var mensagem: Label = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var v_box_container: VBoxContainer = $PanelContainer/MarginContainer/VBoxContainer
@onready var hbox_ok: HBoxContainer = $PanelContainer/MarginContainer/VBoxContainer/Hbox
@onready var ok: Button = $PanelContainer/MarginContainer/VBoxContainer/Hbox/ok
@onready var timer: Timer = $Timer
var hboxs_propriedades: Array [HBoxContainer]
var labels_propriedades: Array[Label]
var botoes_adicionar: Array[Button]
var botoes_remover: Array[Button]
var nome_jogador: String
var valores_propriedades: Array[int]
var divida: int
var propriedades_vendidas: Array[bool]
var adicionar_ativado: bool = true
var remover_ativado: bool = false

func _ready() -> void:
	pass


func set_mensagem(texto: String) -> void:
	if is_instance_valid(mensagem):
		mensagem.text = texto
	
	else:
		print("Error")


func set_nome_jogador(nome: String):
	nome_jogador = nome

func manter_hbox_final():
	var total_children = v_box_container.get_child_count()
	v_box_container.move_child(hbox_ok, total_children-1)
	
	
func set_propriedades_possuidas(propriedades: Array[Espaco], valor_propriedades: Array[int]):
	
	self.valores_propriedades = valor_propriedades.duplicate()
	propriedades_vendidas.resize(propriedades.size())
	var i = 0
	labels_propriedades.resize( propriedades.size())
	botoes_adicionar.resize( propriedades.size())
	botoes_remover.resize(propriedades.size())
	
	while i < propriedades.size():
		var novo_hbox = HBoxContainer.new()
		var nova_label = Label.new()
		var novo_botao_adicionar = Button.new()
		var novo_botao_remover = Button.new()
		
		nova_label.text = propriedades[i].nome+" valor: R$"+ str(valores_propriedades[i])
		novo_botao_adicionar.text = "Adicionar"
		novo_botao_remover.text = "Remover"
		
		nova_label.theme = load("res://src/assets/art/DefaultTheme.tres")
		novo_botao_adicionar.theme = load("res://src/assets/art/DefaultTheme.tres")
		novo_botao_remover.theme = load("res://src/assets/art/DefaultTheme.tres")
		
		novo_botao_adicionar.pressed.connect(_on_botao_adicionar_pressed)
		novo_botao_remover.pressed.connect(_on_botao_remover_pressed)
		
		hboxs_propriedades.append(novo_hbox)
		labels_propriedades[i] = nova_label
		botoes_adicionar[i] = novo_botao_adicionar
		botoes_remover[i] = novo_botao_remover
		
		novo_botao_adicionar.pressed.connect(_on_botao_adicionar_pressed.bind(i))
		novo_botao_remover.pressed.connect(_on_botao_remover_pressed.bind(i))
		
		var spacer = Control.new()
		spacer.size_flags_horizontal = Control.SIZE_EXPAND
		
		v_box_container.add_child(novo_hbox)
		novo_hbox.add_child(nova_label)
		nova_label.add_child(spacer)
		novo_hbox.add_child(novo_botao_adicionar)
		novo_hbox.add_child(novo_botao_remover)
		
		i += 1
	
	manter_hbox_final()


func set_divida(d: int):
	divida = d


func _on_botao_adicionar_pressed(idx: int):
	print("Botao adicionar ativado")
	if !adicionar_ativado:
		divida -= valores_propriedades[idx]
		label_divida.text =  "R$ "+str(divida)
		propriedades_vendidas[idx] = true
		adicionar_ativado = true
		remover_ativado = false


func _on_botao_remover_pressed(idx: int):
	print("Botao remover ativado")
	if adicionar_ativado:
		divida += valores_propriedades[idx]
		label_divida.text = str(divida)
		propriedades_vendidas[idx] = false
		remover_ativado = true
		adicionar_ativado = false


func _on_botao_ok_pressed():
	if divida <= 0:
		destruir()
	
	else:
		label_titulo.text = "Valor da divida nao foi alcançado ainda"
		timer.start()
		await(timer.timeout)
		label_titulo.text = "Voce precisa vender propriedades para pagar a divida!"


func destruir() -> void:
		queue_free()
