(** blockchan_data directory already exists **)
exception Directory_exists of string

(** Could not create the directory **)
exception Directory_creation_failed of string

(** Create a blockchan_data directory at the specified path **)
val init_fs_exn : string -> string -> unit

(** Propagates a transaction to the disk in readable form **)
val propagate_transaction : string -> Transaction.t -> unit

(** Propagates all the transactions of a block **)
val write_block : string -> Block.t -> unit
