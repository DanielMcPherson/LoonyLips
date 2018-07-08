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
	$Blackboard/OKButton/RichTextLabel.text = "OK!"
	$Blackboard/TextBox.grab_focus()
	handle_display()

func _on_OKButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		var new_text = $Blackboard/TextBox.text
		_on_TextBox_text_entered(new_text)

func _on_TextBox_text_entered(new_text):
	$Blackboard/TextBox.clear()
	words.append(new_text)
	handle_display()

func is_story_done():
	return words.size() >= prompts.size()
	
func handle_display():
	if words.size() == 0:
		show_introduction()
	elif is_story_done():
		tell_story()
	else:
		prompt_player();

func show_introduction():
	# Introduction includes first prompt
	$Blackboard/StoryText.text = introduction
	
func prompt_player():
	$Blackboard/StoryText.text = "Please enter " + prompts[words.size()]
	
func tell_story():
	$Blackboard/StoryText.text = story % words
	end_game()
	
func end_game():
	#$Blackboard/TextBox.visible = false
	$Blackboard/TextBox.queue_free()
	$Blackboard/OKButton/RichTextLabel.text = "Again!"