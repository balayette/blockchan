(** blockchan_data directory already exists **)
exception Directory_exists of string

(** Could not create the directory **)
exception Directory_creation_failed of string

let init_fs_exn path =
  try
    let path = path ^ "/blockchan_data" in
    if Sys.is_directory path then (
      raise (Directory_exists path)
    )
    else (
      raise (Directory_creation_failed path)
    )
  with
    Sys_error _ -> (
      print_string "Creating the directory"
    )
