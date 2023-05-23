
extends Area2D


var velocidade = 150

func _ready():
	
	set_process(true)
	
	
func _process(delta):
	var deslocamento = 150*delta*-1
	
	set_global_pos(get_global_pos()+Vector2(deslocamento,0))
	
	var pos = get_global_pos().x
	
	var tamanho = get_item_rect().size.width
	
	var inicio = tamanho/2
	
	if pos<= inicio + deslocamento + (-30):
		queue_free()
	
	
	
	
	
func _on_TiroCorona_area_enter( area ):
	if "jogador" in area.get_groups():
		if area.has_method("leva_dano"):
			area.leva_dano(1)
		queue_free()
