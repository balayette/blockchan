(** Block type **)
type t

(** Create the genesis block **)
val genesis_block : unit -> t

(** Create a new block from the latest block and a list of transactions **)
val new_block : t -> Transaction.t list -> t

(** Compute the hash of the block **)
val block_hash : int -> Transaction.t list -> int -> string

(** Get the id of the block **)
val get_id : t -> int

(** Get the timestamp of the block **)
val get_timestamp : t -> int

(** Get the transaction list of the block **)
val get_transactions : t -> Transaction.t list

(** Get the previous hash of the block **)
val get_previous_hash : t -> string

(** Print block to stdout **)
val print_block : t -> unit

(** Get the hash of the block **)
val get_hash : t -> string

(** Convert a Json_ds_t.block_json to a block **)
val block_of_json_ds : Json_ds_t.block_json -> t

(** Convert a block to a Json_ds_t.block **)
val json_ds_of_block : t -> Json_ds_t.block_json

(** Convert a json string to a block **)
val block_of_string : string -> t
