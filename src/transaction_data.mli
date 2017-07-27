(** The type of the transaction **)
type transaction_type =
  | NEW_THREAD
  | REPLY
  | ARCHIVE

(** All the boards available for posting **)
type boards =
  | CONSUMER_TECH
  | TECH
  | RANDOM

(** The transaction_data type **)
type t

(** Create a new transaction **)
val new_transaction_data : ?username:string -> ?thread_name:string -> ?text:string -> ?thread_hash:string ->boards -> transaction_type ->  t

(** Convert a 'boards' into its string representation**)
val string_of_board : boards -> string

(** Converts a string representation into a 'boards' **)
val board_of_string : string -> boards option

(** Converts a 'transaction_type' to a string **)
val string_of_transaction_type : transaction_type -> string

(** Converts a string to a 'transaction_type' **)
val transaction_type_of_string : string -> transaction_type option

(** Prints the transaction data **)
val print_transaction_data : t -> unit

(** Get the board **)
val get_board : t -> boards

(** Get the kind **)
val get_kind : t -> transaction_type

(** Get the username **)
val get_username : t -> string

(** Get the thread_name **)
val get_thread_name : t -> string

(** Get the text **)
val get_text : t -> string

(** Get the thread_hash **)
val get_thread_hash : t -> string

(** Convert a Json_ds_t.transaction_data_json to a transaction_data **)
val transaction_data_of_json_ds : Json_ds_t.transaction_data_json -> t option

(** Convert a transaction_data to a Json_ds_t.transaction_data_json **)
val json_ds_of_transaction_data : t -> Json_ds_t.transaction_data_json
