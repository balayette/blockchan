type t =
  { data : string;
    hash : string;
    data_len : int;
    timestamp : int;
  }

let print_transaction t =
  Printf.printf "TRANSACTION:\ndata : %s\nhash : %s\nlength: %d\ntimestamp : %d\n-------------\n\n\n" t.data t.hash t.data_len t.timestamp

let create_transaction data hash data_len timestamp =
  {data; hash; data_len; timestamp}

let new_transaction data =
  match String.length data with
  | x when x > 1024 -> None
  | data_len -> (
    let hash = Crypto.transaction_hash data in
    Some (create_transaction data hash data_len (int_of_float (Unix.time ())))
  )

let hash tr = tr.hash

let data tr = tr.data

let data_len tr = tr.data_len

let int_of_transaction_type = function
  | NEW_THREAD -> 0
  | REPLY -> 1
  | ARCHIVE -> 2

let transaction_type_of_int = function
  | 0 -> Some NEW_THREAD
  | 1 -> Some REPLY
  | 2 -> Some ARCHIVE
  | _ -> None

let transaction_of_json_ds tj =
  let open Json_ds_t in
  create_transaction tj.data tj.hash tj.data_len tj.timestamp

let json_ds_of_transaction (tr : t) =
  let open Json_ds_t in
  {data = tr.data;
   hash = tr.hash;
   data_len = tr.data_len;
   timestamp = tr.timestamp
  }
