extends Node


#Este node possui um pause_mode como process, ou seja, o estado dele é mantido
#em processo, mesmo que outros nodes e até mesmo o node raiz esteja em pause

func _ready():
	set_process_input(true)
	
		
func _input(event):
	if event.is_action_pressed("ui_pause") && !event.is_echo():
		#is echo --> Quando uma tecla é mantida pressionada, o evento é repeti
		#do várias vezes. Por isso, existe o método is_echo, pra verificar se
		#isso ocorre ou não
		get_tree().set_pause(!get_tree().is_paused())
		
	if get_tree().is_paused():
			get_node("../Menu").show()
	else:
		get_node("../Menu").hide()
	
#item continue do menu
func _on_c_input_event( ev ):
	if ev.is_action_pressed("ui_tiro"):
		get_tree().set_pause(false)
		
func _on_c_mouse_enter():
	get_node("../Menu/Itens/c/continue").set("custom_colors/font_color_shadow",Color(150,0,0,1))
	
func _on_c_mouse_exit():
	get_node("../Menu/Itens/c/continue").set("custom_colors/font_color_shadow",Color(0,0,0,1))	

		
#item new_game do menu
func _on_ng_input_event( ev ):
	if ev.is_action_pressed("ui_tiro"):
		get_parent().new_game()
		
func _on_ng_mouse_enter():
	get_node("../Menu/Itens/ng/new game").set("custom_colors/font_color_shadow",Color(150,0,0,1))
	
func _on_ng_mouse_exit():
	get_node("../Menu/Itens/ng/new game").set("custom_colors/font_color_shadow",Color(0,0,0,1))

#item exit do menu
func _on_e_input_event( ev ):
	if ev.is_action_pressed("ui_tiro") and not ev.is_echo():
		get_tree().set_pause(false)
		get_tree().change_scene("res://Scenes/Menu.tscn")
		
		
func _on_e_mouse_enter():
	get_node("../Menu/Itens/e/exit").set("custom_colors/font_color_shadow",Color(150,0,0,1))
	
func _on_e_mouse_exit():
	get_node("../Menu/Itens/e/exit").set("custom_colors/font_color_shadow",Color(0,0,0,1))



