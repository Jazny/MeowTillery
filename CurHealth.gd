extends RichTextLabel

var curHealth = 800

export (Color,RGB) var text_color

func _ready():
	set_modulate(text_color)
	ALIGN_CENTER

func _process(delta):
	
	curHealth = get_parent().get_node("MiniBossHealth").value
	#if $CurHealth != null:
	self.text="Robert Scrum: " + str(curHealth) + "/800"
	
	
