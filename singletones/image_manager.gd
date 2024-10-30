extends Node


var brick_images: Array = []


func _ready():
	load_brick_images()


func add_file_to_list(fn: String, path: String) -> void:
	var full_path = path + "/" + fn
	
	var dict = {
		"brick_name": fn.rstrip(".remap"),
		"brick_texture": load(full_path.rstrip(".remap"))
	}
	
	brick_images.append(dict)


func load_brick_images() -> void:
	var path = "res://assets/images/bricks/"
	var dir = DirAccess.open(path)
	
	if not dir:
		print("Error: ", path)
		return
	
	var file_names = dir.get_files()
	
	for fn in dir.get_files():
		if ".import" in fn:
			add_file_to_list(fn.trim_suffix(".import"), path)


func get_random_brick_image() -> Dictionary:
	return brick_images.pick_random()


func get_brick_texture(index: int, state: int) -> Texture:
	return brick_images[index * 2 + state]["brick_texture"]



