extends Node2D

# Prompts for player words to be used in the story
var prompts = [ "your name", "a place", "a living thing", "a color", "a food", "a piece of clothing", "a body part" ]
# Words that player enters to match the prompts 
var words = []
# Story that words will be inserted into
var story = "%s's story:\n\nI went to %s with a %s. We ate %s %s and I wore a %s on my %s."
# Introduction text
var introduction = "Welcome to Loony Lips!\nPlease enter your name to start."
	
func _ready():
	$Blackboard/TextBox.clear()
	$Blackboard/TextBox.grab_focus()
	handle_display()

func handle_display():
	if words.size() == 0:
		show_introduction()
	elif words.size() < prompts.size():
		prompt_player();
	else:
		tell_story()

func show_introduction():
	# Introduction includes first prompt
	$Blackboard/StoryText.text = introduction
	
func prompt_player():
	$Blackboard/StoryText.text = "Please enter " + prompts[words.size()]
	
func tell_story():
	$Blackboard/StoryText.text = story % words

func _on_OKButton_pressed():
	var new_text = $Blackboard/TextBox.text
	_on_TextBox_text_entered(new_text)

func _on_TextBox_text_entered(new_text):
	$Blackboard/TextBox.clear()
	if words.size() < prompts.size():
		words.append(new_text)
		handle_display()