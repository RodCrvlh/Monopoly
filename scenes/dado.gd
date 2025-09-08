class_name Dado
extends Node2D

@onready var dado_sprite: Sprite2D = $Dado
@onready var animation_player: AnimationPlayer = $Dado/AnimationPlayer
@onready var timer: Timer = $Dado/Timer
var resultado: int
signal dado_foi_rolado(resultado)

func _ready() -> void:
	randomize()
	resultado = 0
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_click"):
		animation_player.play("rolar")
		timer.start()
		
func _on_timer_timeout() -> void:
	resultado = randf_range(1,6)
	print(resultado)
	animation_player.play(str(resultado))
	emit_signal("dado_foi_rolado", resultado)

func get_resultado() -> int:
	return resultado
