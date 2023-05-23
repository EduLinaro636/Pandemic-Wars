
extends Area2D



var velocidade = 200
var pos_y = rand_range(200,500)


func _ready():
	set_global_pos(Vector2(1200,pos_y))
	
	add_to_group("avida")
	
	set_process(true)
	
	connect("area_enter",self,"area_enter")
	
	
func _process(delta):
	var movi = Vector2(-1,0) * delta * velocidade
	
	var pos_nova = get_global_pos() + movi
	
	var tamanho = get_node("Sprite").get_item_rect().size.width
	
	set_global_pos(pos_nova)
	
	if pos_nova.x < -tamanho:
		destroi()
		
		
func area_enter(area):
	var grupos = area.get_groups()
	
	var vida = get_tree().get_nodes_in_group("avida").size()
	
	if "jogador" in grupos and vida>0:
		if area.vida<4:
			area.vida += 1
			get_node("AnimationPlayer").play("pega")
			var vidas = get_parent().get_node("Camera").get_node("HUD/HP/value")
			var vida = TextureFrame.new()
			vida.set_texture(load("res://Sprites/HUD/life.png"))
			vida.set_stretch_mode(4)
			vidas.add_child(vida)
			
			remove_from_group("avida")
		
func emite_som():
	get_node("Som").play("LifeUp")
		
func destroi():
	get_parent().get_node("Nave").nova_vida = 0
	queue_free()
	

