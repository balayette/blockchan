type transaction_type =
  | NEW_THREAD
  | REPLY
  | ARCHIVE

type boards =
  | CONSUMER_TECH
  | TECH
  | RANDOM

type t =
  { board : boards;
    kind : transaction_type;
    (* The fields below will be used and ignored depending on the transaction_type *)

    (* NEW_THREAD uses :
       - username : The username of the user
       - thread_name : The title of the thread
       - text : The text of the OP
    *)
    username : string;
    thread_name : string;
    text : string;

    (* REPLY uses :
       - username
       - text
       - thread_hash : the hash of the thread
    *)

    (* ARCHIVE uses :
       - thread_hash : the hash of the thread that will be archived
    *)
    thread_hash : string;

  }

let new_transaction_data
    board
    kind
    ?(username="Anonymous")
    ?(thread_name="")
    ?(text="I forgot to type a text and should be killed.")
    ?(thread_hash="") =
  {board; kind; username; thread_name; text; thread_hash}

let string_of_board = function
  | CONSUMER_TECH -> "cg"
  | TECH -> "g"
  | RANDOM -> "b"

let board_of_string = function
  | "cg" -> Some CONSUMER_TECH
  | "g" -> Some TECH
  | "b" -> Some RANDOM
  | _ -> None

let int_of_transaction_type = function
  | NEW_THREAD -> 0
  | REPLY -> 1
  | ARCHIVE -> 2

let transaction_type_of_int = function
  | 0 -> Some NEW_THREAD
  | 1 -> Some REPLY
  | 2 -> Some ARCHIVE
  | _ -> None
