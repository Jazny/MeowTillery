extends RichTextLabel

var curHealth = 100

export (Color,RGB) var text_color

func _ready():
	set_modulate(text_color)

func _process(delta):
	
	curHealth = get_parent().value
	#if $CurHealth != null:
	self.text=str(curHealth) + "/100"
	
	
