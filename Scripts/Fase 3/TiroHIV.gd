
extends Area2D


var velocidade = 250

var pos_tiro = Vector2(-1,0)
var pos_jogador

func _ready():
	add_to_group("tiro_inimigo")
	set_process(true)
	if  get_tree().get_nodes_in_group("jogador").size()>0:
		pos_jogador = get_parent().get_node("Nave").get_global_pos()
		
		if abs(pos_jogador.x - get_global_pos().x)>400:
			pos_tiro.x = (pos_jogador.x - get_global_pos().x)/750
			pos_tiro.y = (pos_jogador.y - get_global_pos().y)/750
		else:
			pos_tiro.x = (pos_jogador.x - get_global_pos().x)/350
			pos_tiro.y = (pos_jogador.y - get_global_pos().y)/350
		
		
	
func _process(delta):
	var deslocamento = velocidade*delta
	
	rotate(delta*2)
	
	set_global_pos(get_global_pos()+Vector2(pos_tiro.x*deslocamento,pos_tiro.y*deslocamento))
	
	var pos = get_global_pos()
	
	var tamanho = get_item_rect().size
	
	var inicio = tamanho.x/2
	
	if pos.x<= inicio + deslocamento + (-30) or pos.y <= -20 or pos.y>=620:
		queue_free()
	
func _on_TiroHIV_area_enter( area ):
	if "jogador" in area.get_groups():
		if area.has_method("leva_dano"):
			area.leva_dano(2)
		queue_free()
