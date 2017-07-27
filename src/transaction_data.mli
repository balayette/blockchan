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
val new_transaction_data : boards -> transaction_type -> ?string -> ?string -> ?string -> ?string

(** Convert a 'boards' into its string representation**)
val string_of_board : boards -> string

(** Converts a string representation into a 'boards' **)
val board_of_string : string -> boards option

(** Converts a 'transaction_type' to an int **)
val int_of_transaction_type : transaction_type -> int

(** Converts an int to a 'transaction_type' **)
val transaction_type_of_int : int -> transaction_type option
