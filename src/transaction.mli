(** A transaction on the blockchain **)
type t

(** The type of the transaction **)
type transaction_type

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

(** Convert transaction_type to an int suitable for storage **)
val int_of_transaction_type : transaction_type -> int

(** Convert an int to a transaction_type **)
val transaction_type_of_int : int -> transaction_type option

(** Convert a Json_ds_t.transaction_json to a transaction **)
val transaction_of_json_ds : Json_ds_t.transaction_json -> t

(** Convert a transaction into a Json_ds_t.transaction_json **)
val json_ds_of_transaction : t -> Json_ds_t.transaction_json
