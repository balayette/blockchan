(** A transaction on the blockchain **)
type t

(** Create a transaction from data **)
val new_transaction : Transaction_data.t -> t

(** Print the transaction to stdout **)
val print_transaction : t -> unit

(** Get he hash **)
val get_hash : t -> string

(** Get the data **)
val get_data : t -> Transaction_data.t

(** Get the timestamp **)
val get_timestamp : t -> int

(** convert a json_ds_t.transaction_json to a transaction **)
val transaction_of_json_ds : Json_ds_t.transaction_json -> t option

(** convert a transaction into a json_ds_t.transaction_json **)
val json_ds_of_transaction : t -> Json_ds_t.transaction_json

