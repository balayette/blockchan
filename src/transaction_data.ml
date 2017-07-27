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

let get_board t = t.board

let get_kind t = t.kind

let get_username t = t.username

let get_thread_name t = t.thread_name

let get_text t = t.text

let get_thread_hash t = t.thread_hash

let new_transaction_data
    ?(username="Anonymous")
    ?(thread_name="")
    ?(text="I forgot to type a text and should be killed.")
    ?(thread_hash="")
    board
    kind =
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

let transaction_type_of_string = function
  | "NEW_THREAD" -> Some NEW_THREAD
  | "REPLY" -> Some REPLY
  | "ARCHIVE" -> Some ARCHIVE
  | _ -> None

let string_of_transaction_type = function
  | NEW_THREAD -> "NEW THREAD"
  | REPLY -> "REPLY"
  | ARCHIVE -> "ARCHIVE"

let print_transaction_data td =
  Printf.printf "Transaction data :\n";
  Printf.printf "   type : %s\n" (string_of_transaction_type td.kind);
  Printf.printf "   board : %s\n" (string_of_board td.board);
  Printf.printf "   username : %s\n" td.username;
  Printf.printf "   thread name : %s\n" td.thread_name;
  Printf.printf "   text : %s\n" td.text;
  Printf.printf "   thread_hash : %s\n" td.thread_hash;
  print_string "....\n"

let transaction_data_of_json_ds ds =
  let open Json_ds_t in
  let b = board_of_string ds.board
  and k = transaction_type_of_string ds.kind in
  match (b, k) with
  | (None, _) | (_, None) -> None
  | (Some bo, Some ki) -> Some (new_transaction_data
                            ~username:ds.username
                            ~thread_name:ds.thread_name
                            ~text:ds.text
                            ~thread_hash:ds.thread_hash
                            bo
                            ki)

let json_ds_of_transaction_data td = ()
