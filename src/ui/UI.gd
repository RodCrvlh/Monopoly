extends CanvasLayer
class_name UI

@onready var rolar_dados: BoxContainer = $RolarDados
@onready var dados_animation_1: Node2D = $DadosAnimation/DadosAnimation1
@onready var dados_animation_2: Node2D = $DadosAnimation/DadosAnimation2


func _ready():
	rolar_dados.visible = true
	
func set_rolar_dados_visibility(b: bool):
	rolar_dados.set_button_visibility(b)
	rolar_dados.visible = b 

func animacao_rolar(res1: int, res2: int):
	dados_animation_1.animacao_rolar(res1)
	dados_animation_2.animacao_rolar(res2)
