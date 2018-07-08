extends Node2D

# Words that player enters to match the prompts 
var words = []
# Introduction text
var introduction = "Welcome to Loony Lips!\nPlease enter your name to start."
var template = [ 
	{
	"prompts": [ "your name", "a place", "a living thing", "a color", "a food", "a piece of clothing", "a body part" ],
	"story": "%s's story:\n\nI went to %s with a %s. We ate %s %s and I wore a %s on my %s."
	},
	{
	"prompts": [ "your name", "a color", "a material", "a name", "an animal", "a feeling", "a color", "a food", "a body part" ],
	"story": "%s's space story:\n\nI was hurtling through space on a %s rocket made of %s with my copilot %s, an artificially intelligent %s. I was feeling %s until an alarm blared. We were about to crash into a %s asteroid made of %s! A piece of the asteroid smashed into the side of our ship, knocking me out of my seat. Fortunately, I was able to activate the thrusters with my %s, steering us out of the way just in the nick of time."
	},
	{
	"prompts": [ "your name", "a feeling", "a noun", "a place", "a color", "an appliance", "a body part", "a smell", "a piece of furniture" ],
	"story": "%s's story:\n\nI was feeling %s because my favorite %s was missing. I checked in the %s, the %s %s, and even under my %s. Finally I smelled something %s. I followed my nose and found that it was in my %s all along."
	}
]
var current_story
	
func _ready():
	randomize();
	current_story = template[randi() % template.size()]
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
	return words.size() >= current_story.prompts.size()
	
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
	$Blackboard/StoryText.text = "Please enter " + current_story.prompts[words.size()]
	
func tell_story():
	$Blackboard/StoryText.text = current_story.story % words
	end_game()
	
func end_game():
	#$Blackboard/TextBox.visible = false
	$Blackboard/TextBox.queue_free()
	$Blackboard/OKButton/RichTextLabel.text = "Again!"