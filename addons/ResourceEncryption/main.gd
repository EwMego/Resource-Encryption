@icon('icon.svg')
static func _globalize_path (path: String) -> String:
	return ProjectSettings.globalize_path(path)
	
	
static func _validate (path: String) -> bool:
	path = _globalize_path(path)
	var extension:String = path.get_extension()
	if extension.is_empty():
		make_folders(path)
	else:
		var next_path = path.get_base_dir()
			
		make_folders(next_path)
		
		
	return true

static func make_folders (path: String) -> void:
	return DirAccess.make_dir_recursive_absolute(path)
