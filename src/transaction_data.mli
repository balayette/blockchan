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

type t

val new_transaction_data : boards -> transaction_type -> ?string -> ?string -> ?string -> ?string

val string_of_board : boards -> string

val board_of_string : string -> boards option

val int_of_transaction_type : transaction_type -> int

val transaction_type_of_int : int -> transaction_type option
