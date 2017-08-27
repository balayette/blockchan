(** blockchan_data directory already exists **)
exception Directory_exists of string

(** Could not create the directory **)
exception Directory_creation_failed of string

let create_dir path =
  Printf.printf "Creating directory %s\n" path;
  Unix.mkdir path 0o755;
  print_string "Directory created\n"

let init_fs_exn path ip =
  try
    if Sys.is_directory path then (
      raise (Directory_exists path)
    )
    else (
      raise (Directory_creation_failed path)
    )
  with
    Sys_error _ -> (
      create_dir path;
      Printf.printf "Creating %s/server\n" path;
      Core.Out_channel.write_lines (path ^ "/server") [ip];
      print_string "Created\n";
      create_dir (path ^ "/blocks");
      create_dir (path ^ "/blockchan");
      create_dir (path ^ "/blockchan/boards");
      create_dir (path ^ "/blockchan/boards/g");
      create_dir (path ^ "/blockchan/boards/cg");
      create_dir (path ^ "/blockchan/boards/b");
    )

