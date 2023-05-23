
extends Area2D


var velocidade = 350

func _ready():
	set_process(true)
	get_node("Sample").play("TiroNave")
	

func _process(time):
	set_pos(get_pos()+ Vector2(1,0)*time*velocidade)
	
	if(get_pos().x + get_item_rect().size.width/2>1088 or get_pos().x<-20):
		queue_free()




func _on_Tiro_area_enter( area ):
	var grupo = area.get_groups()
	
	var ponto = get_parent().get_node("Camera/HUD/SCORE/value")
	
	if main.INIMIGOS in grupo:
		
		ponto.text = str(int(ponto.text)+10)
		
		if area.has_method("aplica_dano"):
			area.aplica_dano(1)
		
		else:
			area.queue_free()
			
		queue_free()
	elif main.CHEFE in grupo:
		ponto.text = str(int(ponto.text)+10*main.dificuldade)
		area.leva_dano(1)
		queue_free()
	elif "tiro_inimigo" in grupo:
		area.queue_free()
		queue_free()
		
	


