@icon('icon.svg')
extends 'main.gd'
class_name ResourceEncryptionSaver

static func save_with_key (resource: Resource, path: String, key: String = '') -> void:
	if _validate(path):
		path = _globalize_path(path)
		var temp = path.get_basename() + '/temp.tres'
		
		make_folders(temp.get_base_dir())
		var response = ResourceSaver.save(resource, temp)
		
		if response == OK:
			var file = FileAccess.open_encrypted_with_pass(path, FileAccess.WRITE, key)
			
			var resource_text_file = FileAccess.open(temp, FileAccess.READ)
			var content = resource_text_file.get_as_text()
			var json_string = JSON.stringify(content)
			resource_text_file.close()
			
			file.store_string(json_string)
			
			file.close()
			
			DirAccess.remove_absolute(temp)
			DirAccess.remove_absolute(temp.get_base_dir())
		else:
			print("Resource saving failed")
		
