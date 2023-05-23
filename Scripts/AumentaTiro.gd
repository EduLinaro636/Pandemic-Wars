extends Area2D



var velocidade = 200
var pos_y = rand_range(200,500)


func _ready():
	set_global_pos(Vector2(1200,pos_y))
	
	add_to_group("atiro")
	
	set_process(true)
	
	connect("area_enter",self,"area_enter")
	
	
func _process(delta):
	var movi = Vector2(-1,0) * delta * velocidade
	
	var pos_nova = get_global_pos() + movi
	
	var tamanho = get_node("Sprite").get_item_rect().size.width
	
	set_global_pos(pos_nova)
	
	if pos_nova.x < -tamanho:
		queue_free()
		
func area_enter(area):
	var grupos = area.get_groups()
	
	var tiro = get_tree().get_nodes_in_group("atiro").size()
	
	if "jogador" in grupos and tiro>0:
		area.especial = 1
		get_node("AnimationPlayer").play("pega")
		remove_from_group("atiro")
		
		
		
func emite_som():
	get_node("Som").play("PowerUp")
		
	
	

