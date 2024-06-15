@icon('icon.svg')
extends 'main.gd'
class_name ResourceEncryptionLoader


static func load_with_key (path: String, key: String = '') -> Resource:
	if _validate(path):
		path = _globalize_path(path)
		
		var exists = FileAccess.file_exists(path)
		if exists:
			var read_file = FileAccess.open_encrypted_with_pass(path, FileAccess.READ, key)
			if read_file == null:
				
				return
				
			var content = JSON.parse_string(read_file.get_as_text())
			var temp = path.get_basename() + '/temp.tres'
			
			make_folders(temp.get_base_dir())
			var tres = FileAccess.open(temp, FileAccess.WRITE)
			tres.store_string(content)
			tres.close()
			
			
			var res = ResourceLoader.load(temp)
			var clone = res.duplicate()	
			read_file.close()
			DirAccess.remove_absolute(temp)
			DirAccess.remove_absolute(temp.get_base_dir())
			
			return clone
		else:
			print('File not found!')
			
	return null
