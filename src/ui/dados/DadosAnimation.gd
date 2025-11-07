extends Node

@onready var dado_sprite: Sprite2D = $Dado
@onready var animation_player: AnimationPlayer = $Dado/AnimationPlayer
@onready var timer: Timer = $Dado/Timer
var resultado: int
signal dado_foi_rolado(resultado)
var can_click: bool = true

func _ready() -> void:
	randomize()
	resultado = 0
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_click") and can_click:
		can_click = false
		animation_player.play("rolar")
		timer.start()
		
func _on_timer_timeout() -> void:
	resultado = randf_range(1,6)
	animation_player.play(str(resultado))
	emit_signal("dado_foi_rolado", resultado)
