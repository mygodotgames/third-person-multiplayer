extends Node3D

var PLAYER = preload("res://player/player.tscn")
var peer = ENetMultiplayerPeer.new()

func _on_host_button_pressed() -> void:
	peer.create_server(1337)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(
		func(pid):
			print("Peer " + str(pid) + " has joined!")
			add_player(pid)
	)
	add_player(multiplayer.get_unique_id())
	$UI/Label.text = "Server"
	$UI.visible = false

func _on_client_button_pressed() -> void:
	peer.create_client("localhost", 1337)
	multiplayer.multiplayer_peer = peer
	$UI/Label.text = "Client"
	$UI.visible = false

func add_player(pid):
	var player = PLAYER.instantiate()
	player.name = str(pid)
	add_child(player)
