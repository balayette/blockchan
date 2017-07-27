(** A transaction on the blockchain **)
type t

(** Create a transaction from data **)
val new_transaction : Transaction_data.t -> t

(** Print the transaction to stdout **)
val print_transaction : t -> unit

(** Get the hash **)
val hash : t -> string

(** Get the data **)
val data : t -> Transaction_data.t

(* (\** Convert a Json_ds_t.transaction_json to a transaction **\) *)
(* val transaction_of_json_ds : Json_ds_t.transaction_json -> t *)

(* (\** Convert a transaction into a Json_ds_t.transaction_json **\) *)
(* val json_ds_of_transaction : t -> Json_ds_t.transaction_json *)
