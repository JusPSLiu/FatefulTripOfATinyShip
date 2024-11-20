extends CanvasLayer

@onready var dialogue_text = $DialogueText
@onready var dialogue_audio = $Dialogue

var text_ratio : float = 0;
var alpha : float = 1;
var hideText : bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (text_ratio < 1):
		text_ratio = expDecay(dialogue_text.visible_ratio, 1.1, 12, delta)
		if (text_ratio > 1):
			text_ratio = 1
		dialogue_text.visible_ratio = text_ratio
	if (hideText):
		alpha -= delta*0.8
		if (alpha < 0):
			alpha = 0
			hideText = false
		dialogue_text.modulate = Color(1,1,1,alpha)

func play_dialogue(num):
	text_ratio = 0
	dialogue_text.visible_ratio = 0
	dialogue_text.modulate = Color(1,1,1,1)
	match(num):
		0:
			dialogue_text.text = "[bgcolor=#000a][center]"+"this is dialogue lololol"
		_:
			dialogue_text.text = "[bgcolor=#000a][center]"+"this is other dialogue lololol"
	
	dialogue_audio.play()
	await (dialogue_audio.finished)
	if (true): hide_the_text()

func hide_the_text():
	hideText = true
	alpha = 1


# i saw a yt video by freya holmer abt this being a better exponential lerp
func expDecay(a, b, decay, dt):
	return b+(a-b)*exp(-decay*dt)
