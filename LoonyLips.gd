extends Node2D

# Prompts for player words to be used in the story
var prompts = [ "your name", "a place", "a living thing", "a color", "a food", "a piece of clothing", "a body part" ]
# Words that player enters to match the prompts 
var words = []
# Story that words will be inserted into
var story = "%s's story.\n\nI went to %s with a %s. We ate %s %s and I wore a %s on my %s."
# Introduction text
var introduction = "Welcome to Loony Lips!\nPlease enter your name to start."
	
func _ready():
	$Blackboard/TextBox.clear()
	$Blackboard/TextBox.grab_focus()
	prompt_player()

func prompt_player():
	var text
	if words.size() == 0:
		# Intro and prompt for first word
		text = introduction
	elif words.size() < prompts.size():
		# Prompt for next word
		text = "Please enter " + prompts[words.size()]
	else:
		# Display completed story
		text = story % words
	$Blackboard/StoryText.text = text

func _on_OKButton_pressed():
	var new_text = $Blackboard/TextBox.text
	_on_TextBox_text_entered(new_text)

func _on_TextBox_text_entered(new_text):
	$Blackboard/TextBox.clear()
	if words.size() < prompts.size():
		words.append(new_text)
		prompt_player()
