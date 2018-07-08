extends Node2D

func _ready():
	$Blackboard/TextBox.clear()
	var prompts = [ "place", "living thing", "color", "food", "piece of clothing", "body part" ]
	var words = [ "Spain", "cow", "green", "pizza", "hat", "elbow" ]
	var story = "I went to %s with a %s. We ate %s %s and I wore a %s on my %s." 
	$Blackboard/StoryText.text = story % words

func _on_OKButton_pressed():
	var new_text = $Blackboard/TextBox.text
	_on_TextBox_text_entered(new_text)

func _on_TextBox_text_entered(new_text):
	print("Entered text: " + new_text)
	$Blackboard/StoryText.text = new_text
	$Blackboard/TextBox.clear()
