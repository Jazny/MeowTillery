extends RichTextLabel

var curHealth = 850

export (Color,RGB) var text_color

func _ready():
	set_modulate(text_color)
	ALIGN_CENTER

func _process(delta):
	
	curHealth = get_parent().get_node("Rob2Health").value
	#if $CurHealth != null:
	self.text="Rob2: " + str(curHealth) + "/850"
	
	
