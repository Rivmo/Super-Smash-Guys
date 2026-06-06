extends OptionButton

func _ready() -> void:
	var button = self
	var setlanguage := TranslationServer.get_locale()
	if setlanguage == "en_US":
		button.selected = 0
	elif setlanguage == "es":
		button.selected = 1
	else: print("Error, couldn't find translation")
		
		
func _on_item_selected(index: int) -> void:
	if index == 0:
		TranslationServer.set_locale("en_US")
	elif index == 1:
		TranslationServer.set_locale("es")
	else: print("Error, No translation selected")
