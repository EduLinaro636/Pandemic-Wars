
extends Camera2D


var velocidade = 100
var shake = 0

func _ready():
	
	set_process(true)
	
func _process(delta):
	set_offset(get_offset()+Vector2(1,0)*delta*velocidade)
	
	if shake>0:
		set_pos(Vector2(cos(rad2deg(shake)),sin(rad2deg(shake)))*10)
		shake=0
	else:
		set_pos(Vector2(0,0))


func shake():
	shake = 1
	
	
	

