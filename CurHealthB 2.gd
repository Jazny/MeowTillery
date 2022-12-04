extends RichTextLabel

var curHealth = 100

export (Color,RGB) var text_color

func _ready():
	set_modulate(text_color)
	ALIGN_CENTER

func _process(delta):
	
	curHealth = get_parent().get_node("BossHealth").value
	#if $CurHealth != null:
	self.text="Ingrid: " + str(curHealth) + "/100"
	
	
