extends Control

var dialog = [
	'Hello there.',
	'Hey.',
	"How's it hanging?",
	"What's up?",
	"So, how is life going?",
	"I haven't seen you in ages!",
	"What have you been doing?",
	"How's life going?",
	"Whatcha doing?",
	"I love this new cat cafe!",
	"What are you up to?",
	"Wanna buy some heroin?",
	"So, is it just me, or does nyone else want a pistachio cappuccino?",
	"Are you that coffee person?",
	"Where is Squango when you need it?",
	"uGH, why is Pita here?",
	"Why are we still here?",
	"Can I get a uhhhh, nevermind.",
	"Where are all the cats?",
	"I love cats!",
	"How is it hanging?",
	"I don't enjoy pita or PITA!",
	"What's happening my main guy?",
	"So, you work here?",
	"Have you seen the kitties!!",
	"So, how's life treating you?",
	"So, PITA is back around? And I thought my day couldn't get worse.",
	"So, what is cooking? Oh, I mean brewing?",
	"Do I have to pay to hold the cats?",
	"So, could you add even more cats?",
	"How are you doing all of this?",
	"So, what's the vibe of this place?",
	"A cat cafe? What a novel concept.",
	"You look absolutely fabulous, darling!",
	"PITA cannot be back! They're crazy.",
	"Listen, PITA is terrible and someone needs to deal with them.",
	"What's controversial about this place?",
	"Why can't I pick up the kitties?",
	"So, there are how many cats?",
	"There is so much fur everywhere!",
	"This place is meowsome! Sorry, I couldn't resist.",
	"So, is something happening over there?",
	"Does this place serve hummus?",
	"What's with the giant Macaroon?",
	"Is that cat glowing?",
	"Is it just me or is that a ghost cat?",
	"So, are we going to mention why that cat is glowing green?",
	"I took the wrong door, and wound up in some weird cat dungeon?!",
	"My favorite punctuation mark is the interrobang because I am quirky.",
	"How come nobody has taken my order yet?",
	"I am so thankful that these walls are just so soft because otherwise, I would just not wlak into them.",
	"Say, why haven't we come here before?",
	"So, why is this place called Meowtillery?",
	"Tell me why! Ain't nothing but a heartache!",
	"Why didn't we come earlier?",
	"I need to tell my husband about this place.",
	"I need to tell my sister about this place.",
	"I need to tell my bros about this place.",
	"I really should find spend more time here.",
	"I need to tell my wife about this place.",
	"My girlfriend would love it here.",
	"My boyfriend would love it here.",
	"Why do we do this too ourselves?",
	"Would it be a bad time to mention that I am allergic to cats?",
	"I need to pet all the cats in this place!",
	"I actually don't like coffee.",
	"So, are you able to deal with all this?",
	"This would be a great place for a DnD game!",
	"So, are we just going to ignore PITA?",
	"So, how much is it for a pistachio cappuccino?",
	"Do you guys make skim goat milk double espresso shot chai lattes or is that the other place?",
	"So, what drinks are you known for?",
	"What's the meaning of life?",
	"So, what's on the menu?",
	"Did you see the witch outside?",
	"So, is this supposed to look like this?",
	"Can I pick up the cats?",
	"Why do none of the cats wanna snuggle with me?",
	"Writing Dialogue all day and not petting cats makes this NPC a very dull boy.",
	"So, what can I get to drink?",
	"Is it too early for an Irish Coffee?",
	"So, anyone wanna play a tabletop game?",
	"So, do you have carmel macchiatos?",
	"This isn't the kind of place for a rum and coke? But, oh nevermind.",
	"I have been very busy doing paperwork for my very real job.",
	"So, if the make Cat Cafes? Why not make Dog Desserterie or a Bird Bistro?",
	"Kitties!",
	"They're so cute and fluffy!",
	"We need to get cats now!",
	"I really hate PITA.",
	"CATS!",
	"I found my calling! To get as many cats as possible!",
	"So, can we appreciate the fluffy cats?",
	"This coffee is to die for!",
	"This place was looking sus. I almost thought it was run by PITA.",
	"How can we be sure that PITA isn't involved?",
	"So, what all are we doing?",
	"How did I get here? Oh! Nevermind, cats!",
	"I came for the coffee, and I stayed for the cats.",
	"So, are you going to the party?",
	"So, why aren't we here all the time?",
	"I certainly hope that I haven't repeated myself at all.",
	"What else can I even say?",
	"Oh, hello. Goodbye.",
	"There is something sus about PITA.",
	"This is why we should legalize serfdom, and here's my TED talk on why.",
	"I woke up and chose cats today.",
	"So, there are only so many things to say, but so much time to say it.",
	"This is not a story that PITA would tell you. It's an old cat legend.",
	"So, can I order now?",
	"Damn, I need to pet some cats.",
	"Looks like I have come to the right place.",
	"This was quite difficult.",
	"Please help me, I am too weak to keep petting cats.",
	"Welcome to the cafe, no I don't work here.",
	"I enjoy all kinds of cats, orange ones, black ones, the weird glowing ones. All of them!",
	"So, what do we want? A coffee worth fighting for!",
	"How much for a gian macaroon?",
	"So, why can't I get more macaroons?",
	"My favorite color is beige.",
	"Why does everyone keep walking into walls? Including me!",
	"How come there aren't enough events in this place."
]

var dialog_index = RandomNumberGenerator.new()
var finished = false

func _ready(): 
	load_dialog()

func _process(delta):
	if ($"RichTextLabel".visible == true):
		$"Next-indicator".visible = finished
	
	if(Input.is_action_just_pressed("ui_accept")):
		load_dialog()


func load_dialog():
	dialog_index.randomize()
	var rand_num = dialog_index.randi_range(0, 100)
	if(rand_num < dialog.size()):
		finished = false
		$RichTextLabel.bbcode_text = dialog[rand_num]
		$RichTextLabel.percent_visible = 1
		$Tween.interpolate_property(
			$RichTextLabel, "percent_visible", 0, 1, 1, 
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$Tween.start()

	
func _on_Tween_tween_completed(object, key):
	finished = true
