(** blockchan_data directory already exists **)
exception Directory_exists of string

(** Could not create the directory **)
exception Directory_creation_failed of string

(** Create a blockchan_data directory at the specified path **)
val init_fs_exn : string -> bool
