(** A transaction on the blockchain **)
type t
(** Create a transaction from data **)
val new_transaction : string -> t option

(** Print the transaction to stdout **)
val print_transaction : t -> unit

(** Get the hash **)
val hash : t -> string

(** Get the data **)
val data : t -> string

(**  Get the data length **)
val data_len : t -> int
