(** Only for use by other modules. **)
val transaction_hash : Transaction_data.t -> string

(** Only for use by other modules **)
val block_hash : int -> string list -> int -> string

(** Thread hash **)
val thread_hash : string -> string -> string -> string -> string
