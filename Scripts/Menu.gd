extends Container


func _ready():
	if main.dificuldade==1:
			get_node("Dificuldade/Facil/Label").set("custom_colors/font_color",Color(0.8,0.1,0.1,1))
	elif main.dificuldade==2:
			get_node("Dificuldade/Medio/Label").set("custom_colors/font_color",Color(0.8,0.1,0.1,1))
	elif main.dificuldade==3:
			get_node("Dificuldade/Dificil/Label").set("custom_colors/font_color",Color(0.8,0.1,0.1,1))


#Hover sobre os itens do menu
func _on_NJ_mouse_enter():
	get_node("LogoItens/Itens/Novo Jogo/Label").set_opacity(0.5)

func _on_NJ_mouse_exit():
	get_node("LogoItens/Itens/Novo Jogo/Label").set_opacity(1)

func _on_D_mouse_enter():
	get_node("LogoItens/Itens/Desenvolvedores/Label").set_opacity(0.5)

func _on_D_mouse_exit():
	get_node("LogoItens/Itens/Desenvolvedores/Label").set_opacity(1)

func _on_S_mouse_enter():
	get_node("LogoItens/Itens/Sair/Label").set_opacity(0.5)

func _on_S_mouse_exit():
	get_node("LogoItens/Itens/Sair/Label").set_opacity(1)

func _on_Difi_mouse_enter():
	get_node("LogoItens/Itens/Dificuldade/Label").set_opacity(0.5)


func _on_Difi_mouse_exit():
	get_node("LogoItens/Itens/Dificuldade/Label").set_opacity(1)


	
#Clique nos itens do menu principal

func _on_NJ_input_event( ev ):
	if ev.is_action_pressed("ui_tiro"):
		main.fase_em_andamento = 0
		main.fase = 1
		get_tree().change_scene("res://Scenes/main.tscn")
	
func _on_S_input_event( ev ):
	if ev.is_action_pressed("ui_tiro"):
		get_tree().get_root().queue_free()


func _on_D_input_event( ev ):
	if ev.is_action_pressed("ui_tiro"):
		get_node("Desenvolvedores").set("visibility/visible",true)
		get_node("LogoItens").set("visibility/visible",false)
		get_node("LogoItens/Itens/Desenvolvedores/Label").set_opacity(1)
	
func _on_Difi_input_event( ev ):
	if ev.is_action_pressed("ui_tiro"):
		get_node("Dificuldade").show()
		get_node("LogoItens").hide()
		get_node("LogoItens/Itens/Dificuldade/Label").set_opacity(1)
		
		
#Item voltar do menu dos nomes dos desenvolvedores

func _on_V_mouse_enter():
	get_node("Desenvolvedores/Voltar/Label").set_opacity(0.5)


func _on_V_mouse_exit():
	get_node("Desenvolvedores/Voltar/Label").set_opacity(1)


func _on_V_input_event( ev ):
	if ev.is_action_pressed("ui_tiro"):
		get_node("Desenvolvedores").set("visibility/visible",false)
		get_node("LogoItens").set("visibility/visible",true)
		get_node("Desenvolvedores/Voltar/Label").set_opacity(1)

#Item voltar do menu de dificuldades

func _on_Vdifi_mouse_enter():
	get_node("Dificuldade/Voltar/Label").set_opacity(0.5)
	
func _on_Vdifi_mouse_exit():
	get_node("Dificuldade/Voltar/Label").set_opacity(1)

func _on_Vdifi_input_event( ev ):
	if ev.is_action_pressed("ui_tiro"):
		get_node("Dificuldade").hide()
		get_node("LogoItens").show()
		get_node("Dificuldade/Voltar/Label").set_opacity(1)

#Itens do menu de dificuldades

#Fácil

func _on_F_mouse_enter():
	get_node("Dificuldade/Facil/Label").set_opacity(0.5)


func _on_F_mouse_exit():
	get_node("Dificuldade/Facil/Label").set_opacity(1)


func _on_F_input_event( ev ):
	if ev.is_action_pressed("ui_tiro"):
		get_node("Dificuldade/Medio/Label").set("custom_colors/font_color",Color(1,1,1,1))
		get_node("Dificuldade/Dificil/Label").set("custom_colors/font_color",Color(1,1,1,1))
		get_node("Dificuldade/Facil/Label").set("custom_colors/font_color",Color(0.8,0.1,0.1,1))
		main.dificuldade = 1
	
#Médio

func _on_M_mouse_enter():
	get_node("Dificuldade/Medio/Label").set_opacity(0.5)


func _on_M_mouse_exit():
	get_node("Dificuldade/Medio/Label").set_opacity(1)


func _on_M_input_event( ev ):
	if ev.is_action_pressed("ui_tiro"):
		get_node("Dificuldade/Facil/Label").set("custom_colors/font_color",Color(1,1,1,1))
		get_node("Dificuldade/Dificil/Label").set("custom_colors/font_color",Color(1,1,1,1))
		get_node("Dificuldade/Medio/Label").set("custom_colors/font_color",Color(0.8,0.1,0.1,1))
		main.dificuldade = 2

#Difícil

func _on_Dl_mouse_enter():
	get_node("Dificuldade/Dificil/Label").set_opacity(0.5)


func _on_Dl_mouse_exit():
	get_node("Dificuldade/Dificil/Label").set_opacity(1)


func _on_Dl_input_event( ev ):
	if ev.is_action_pressed("ui_tiro"):
		get_node("Dificuldade/Facil/Label").set("custom_colors/font_color",Color(1,1,1,1))
		get_node("Dificuldade/Medio/Label").set("custom_colors/font_color",Color(1,1,1,1))
		get_node("Dificuldade/Dificil/Label").set("custom_colors/font_color",Color(0.8,0.1,0.1,1))
		main.dificuldade = 3



