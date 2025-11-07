extends Node

@onready var rolar_dados: BoxContainer = $RolarDados
@onready var dados_animation: Node = $DadosAnimation

func _ready():
	rolar_dados.visible = false
