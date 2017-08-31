(** blockchan_data directory already exists **)
exception Directory_exists of string

(** Could not create the directory **)
exception Directory_creation_failed of string

(** Create a blockchan_data directory at the specified path **)
val init_fs_exn : string -> string -> unit

(** Propagates a transaction to the disk in readable form **)
val propagate_transaction : string -> Transaction.t -> unit

(** Writes a raw block to the blocks/ directory and propagates all 
 * the transactions it contains **)
val write_block : string -> Block.t -> unit

(** Writes all the blocks stored in the filesystem to the blockchann directory **)
val write_all_blocks : string -> unit

(** List.iter over the blocks stored in blocks/ **)
val iter_blocks : ?low:int -> ?count:int -> string -> (Block.t -> unit) -> unit

(** List.for_all over the blocks stored in blocks/ **)
val for_all_blocks : ?low:int -> ?count:int -> string -> (Block.t -> bool) -> bool

(** Write all transactions from blocks/ to blockchan/ **)
val write_all_blocks : string -> unit

(** NOT IMPLEMENTED Sanity-check all blocks individually **)
val check_individual_blocks : string -> bool

(** NOT IMPLEMENTED Sanity-check the whole blockchain **)
val check_blockchain : string -> bool

(** Return a list of blocks from blocks/ Not tail recursive, but doesn't 
 * reverse the list **)
val get_blocks : ?low:int -> ?count:int -> string -> Block.t list

(** Return a list of blocks from blocks/ Tail recursive, but has to reverse 
 * the list before returning it **)
val get_blocks' : ?low:int -> ?count:int -> string -> Block.t list
